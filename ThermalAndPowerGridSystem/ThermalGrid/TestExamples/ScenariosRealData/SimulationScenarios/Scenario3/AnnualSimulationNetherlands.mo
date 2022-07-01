within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario3;

model AnnualSimulationNetherlands
 extends Modelica.Icons.Example;
  ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario3.Netherlands Netherlands annotation(
    Placement(visible = true, transformation(origin = {-46, 31}, extent = {{-209, -122}, {209, 122}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario3.NetherlandsControl NetherlandsControl annotation(
    Placement(visible = true, transformation(origin = {47, -18}, extent = {{-19, -18}, {19, 18}}, rotation = 0)));
equation
  connect(Netherlands.scenarioBus, NetherlandsControl.controllerBus) annotation(
    Line(points = {{-46, 0}, {-46, -68}, {48, -68}, {48, -34}}, color = {255, 204, 51}, thickness = 0.5));

annotation(
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 3600),
    Diagram(graphics = {Text(origin = {47, 12}, lineThickness = 2.5, extent = {{-27, 4}, {27, -4}}, textString = "Scenario Controller"), Text(origin = {-46, 72}, lineThickness = 2.5, extent = {{-40, 12}, {40, -12}}, textString = "Netherlands Scenario")}));
end AnnualSimulationNetherlands;
