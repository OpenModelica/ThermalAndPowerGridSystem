within ThermalAndPowerGridSystem.ThermalGrid.Sensors;

model TemperatureSensor "Returns temperature of fluid stream"
extends SystemSetup.SystemFluid;
  import Modelica.Units.SI.AbsolutePressure;
  import Modelica.Units.SI.SpecificEnthalpy;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
 
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort tSensorInput annotation(
    Placement(visible = true, transformation(origin = {-4, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-30, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput componentTemperatureOP annotation(
    Placement(visible = true, transformation(origin = {37, -69}, extent = {{-19, -19}, {19, 19}}, rotation = 0), iconTransformation(origin = {12, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AbsoluteTemperature componentTemperature;

equation
  componentTemperatureOP = FluidMedium.temperature_phX(tSensorInput.pressure, inStream(tSensorInput.specificEnthalpy),{1});
  componentTemperature = componentTemperatureOP;
   tSensorInput.massFlowRate = 0;
   tSensorInput.specificEnthalpy = -1; 

annotation(
    Icon(graphics = {Rectangle(origin = {-9, -1}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-11, 67}, {11, -67}}), Ellipse(origin = {-9, -66}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-25, 22}, {25, -22}}, endAngle = 360), Ellipse(origin = {-9, 67}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-11, 13}, {11, -13}}, endAngle = 360)}),
    Diagram(graphics = {Rectangle(origin = {-5, -1}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-11, 67}, {11, -67}}), Ellipse(origin = {-5, -66}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-25, 22}, {25, -22}}, endAngle = 360), Ellipse(origin = {-5, 67}, lineColor = {255, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-11, 13}, {11, -13}}, endAngle = 360)}));
end TemperatureSensor;
