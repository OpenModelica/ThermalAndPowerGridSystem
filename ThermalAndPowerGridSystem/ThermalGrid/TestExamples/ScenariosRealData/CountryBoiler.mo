within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData;

model CountryBoiler
extends Modelica.Icons.Example;
  import Modelica.Units.SI.AbsolutePressure;
  inner SystemSetup.AmbientConditions ambientConditions;

  parameter AbsolutePressure sinkPressure = 5e5;
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank hotTank(InitialLevel = 5, PTop(displayUnit = "Pa") = 1e5, TAmb(displayUnit = "K") = 323, tankArea = 100, tankVolume = 3000)  annotation(
    Placement(visible = true, transformation(origin = {73, -29}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange2 annotation(
    Placement(visible = true, transformation(origin = {-69, 1}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Boiler boiler annotation(
    Placement(visible = true, transformation(origin = {-69, -107}, extent = {{-25, -23}, {25, 23}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression fuelFlowRate(y = 6700)  annotation(
    Placement(visible = true, transformation(origin = {-143, -107}, extent = {{-29, -13}, {29, 13}}, rotation = 0)));
  Components.Pump pumpCold2(massFlowRate = 220000) annotation(
    Placement(visible = true, transformation(origin = {-189, -1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SourcePT sourcePT(Pressure(displayUnit = "Pa") = 1e5, Temperature(displayUnit = "K") = 298)  annotation(
    Placement(visible = true, transformation(origin = {-262, -28}, extent = {{-34, -34}, {34, 34}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SinkP sinkP(P(displayUnit = "Pa") = 2e5)  annotation(
    Placement(visible = true, transformation(origin = {231, -19}, extent = {{-41, -41}, {41, 41}}, rotation = 0)));
  Components.Pump pumpoutput(massFlowRate = 220000)  annotation(
    Placement(visible = true, transformation(origin = {158, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(portExchange2.outFlow, hotTank.portA) annotation(
    Line(points = {{-45, 1}, {34.5, 1}, {34.5, 0}}, color = {0, 170, 255}));
  connect(portExchange2.thermalPortIn, boiler.heatOut) annotation(
    Line(points = {{-68, 1}, {-68, -132}, {-69.5, -132}}, color = {255, 0, 0}));
  connect(fuelFlowRate.y, boiler.FuelFlowRate) annotation(
    Line(points = {{-111, -107}, {-96, -107}}, color = {0, 0, 127}));
  connect(pumpCold2.outFlow, portExchange2.inFlow) annotation(
    Line(points = {{-170, -1}, {-114.88, -1}, {-114.88, 0}, {-93, 0}}, color = {0, 170, 255}));
  connect(sourcePT.port, pumpCold2.inFlow) annotation(
    Line(points = {{-244, -28}, {-208, -28}, {-208, 0}}, color = {0, 170, 255}));
  connect(hotTank.portB, pumpoutput.inFlow) annotation(
    Line(points = {{112, -52}, {148, -52}}, color = {0, 170, 255}));
  connect(pumpoutput.outFlow, sinkP.port) annotation(
    Line(points = {{168, -52}, {210, -52}, {210, -20}}, color = {0, 170, 255}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    experiment(StartTime = 0, StopTime = 36000, Tolerance = 1e-06, Interval = 3600));
end CountryBoiler;
