within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ComponentTest.StratifiedTankTest;

model BoreholeStorageSinglePort
extends Modelica.Icons.Example;
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SourceMT sourceMT(massFlowRate = 500, temperature(displayUnit = "K") = 363) annotation(
    Placement(visible = true, transformation(origin = {-90, -6}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions.SinkP sinkP annotation(
    Placement(visible = true, transformation(origin = {74, -40}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Storage.BoreholeTESports boreholeTESports annotation(
    Placement(visible = true, transformation(origin = {-4, -24}, extent = {{-26, -30}, {26, 30}}, rotation = 0)));
equation
  connect(sourceMT.port, boreholeTESports.inlet) annotation(
    Line(points = {{-74, -6}, {-32, -6}}, color = {0, 170, 255}));
  connect(boreholeTESports.outlet, sinkP.port) annotation(
    Line(points = {{24, -40}, {62, -40}}, color = {0, 170, 255}));
  annotation(
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-06, Interval = 63072));
end BoreholeStorageSinglePort;
