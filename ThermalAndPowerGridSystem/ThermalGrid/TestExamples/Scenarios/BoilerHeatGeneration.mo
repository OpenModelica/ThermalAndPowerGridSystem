within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.Scenarios;

model BoilerHeatGeneration
  import Modelica.Units.SI.AbsolutePressure;
  inner SystemSetup.AmbientConditions ambientConditions;
  extends Modelica.Icons.Example;

  parameter AbsolutePressure sinkPressure = 3e5;
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pumpCold(massFlowRate = 3.2e-6)  annotation(
    Placement(visible = true, transformation(origin = {18, -84}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange1 annotation(
    Placement(visible = true, transformation(origin = {130, 42}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SinkP sinkP(P = 999999.9999999999)  annotation(
    Placement(visible = true, transformation(origin = {269, 45}, extent = {{-73, -73}, {73, 73}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SourceMT sourceMT(massFlowRate = 100)  annotation(
    Placement(visible = true, transformation(origin = {-250, 142}, extent = {{-82, -82}, {82, 82}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Boiler boiler annotation(
    Placement(visible = true, transformation(origin = {-210, -82}, extent = {{-96, -96}, {96, 96}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.coldTank coldTank(InitialLevel = 290, PTop(displayUnit = "Pa") = 2e5, tankVolume = 3000)  annotation(
    Placement(visible = true, transformation(origin = {-93, 95}, extent = {{-51, -51}, {51, 51}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression FuelFlowRate(y = 6.86e-8)  annotation(
    Placement(visible = true, transformation(origin = {-354, -77}, extent = {{-14, -13}, {14, 13}}, rotation = 0)));
equation
  connect(boiler.heatOut, portExchange1.thermalPortIn) annotation(
    Line(points = {{-212, -188}, {-212, -152}, {130, -152}, {130, 42}}, color = {255, 0, 0}));
  connect(portExchange1.outFlow, sinkP.port) annotation(
    Line(points = {{164, 42}, {232, 42}, {232, 44}}, color = {0, 170, 255}));
  connect(coldTank.portA, sourceMT.port) annotation(
    Line(points = {{-150, 136}, {-206, 136}, {-206, 140}}, color = {0, 170, 255}));
  connect(coldTank.portB, pumpCold.inFlow) annotation(
    Line(points = {{-36, 62}, {0, 62}, {0, -84}}, color = {0, 170, 255}));
  connect(pumpCold.outFlow, portExchange1.inFlow) annotation(
    Line(points = {{38, -84}, {48, -84}, {48, 42}, {98, 42}}, color = {0, 170, 255}));
  connect(FuelFlowRate.y, boiler.FuelFlowRate) annotation(
    Line(points = {{-339, -77}, {-313, -77}, {-313, -81}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    experiment(StartTime = 0, StopTime = 10000, Tolerance = 1e-06, Interval = 20));
end BoilerHeatGeneration;
