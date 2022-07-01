within ThermalAndPowerGridSystem.ThermalGrid.Components;

model PortExchange1 "This model is used to carry the information of a heat port onto a water port. It can be considered a simple heat exchanger model"
  extends SystemSetup.SystemFluid;
  outer ThermalAndPowerGridSystem.ThermalGrid.SystemSetup.AmbientConditions ambientConditions;
  import Modelica.Units.SI.Pressure;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.ThermalPort thermalPortIn annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort outFlow annotation(
    Placement(visible = true, transformation(origin = {90, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort inFlow annotation(
    Placement(visible = true, transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
//  AbsoluteTemperature temperature;

equation
  if inFlow.massFlowRate <= 1e-3 then
      outFlow.massFlowRate * outFlow.specificEnthalpy = -inFlow.massFlowRate * inStream(inFlow.specificEnthalpy);
  else  
      outFlow.massFlowRate * outFlow.specificEnthalpy = (-thermalPortIn.W) - inFlow.massFlowRate * inStream(inFlow.specificEnthalpy);
  end if;

  outFlow.massFlowRate + inFlow.massFlowRate = 0;
  outFlow.pressure = inFlow.pressure;
  inFlow.specificEnthalpy = inStream(outFlow.specificEnthalpy);
//  temperature = FluidMedium.temperature_phX(inFlow.pressure, outFlow.specificEnthalpy, {1});
 
  annotation(
    Diagram(graphics = {Ellipse(fillColor = {238, 71, 20}, extent = {{-80, 80}, {80, -80}}, endAngle = 360)}),
    Icon(graphics = {Ellipse(fillColor = {238, 71, 20}, extent = {{-80, 80}, {80, -80}}, endAngle = 360)}));
end PortExchange1;
