within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.Scenarios.SimulationScenarios;

model AnnualSimulationSingleHouse
extends Modelica.Icons.Example;
  ThermalAndPowerGridSystem.ThermalGrid.TestExamples.Scenarios.SimulationScenarios.SingleHouse singleHouse annotation(
    Placement(visible = true, transformation(origin = {-57, 42}, extent = {{-85, -54}, {85, 54}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.TestExamples.Scenarios.SimulationScenarios.SingleHouseControl singleHouseControl annotation(
    Placement(visible = true, transformation(origin = {54, -37}, extent = {{-26, -25}, {26, 25}}, rotation = 0)));
equation
  connect(singleHouse.scenarioBus, singleHouseControl.ControllerBus) annotation(
    Line(points = {{-58, 12}, {-56, 12}, {-56, -76}, {54, -76}, {54, -60.5}}, color = {255, 204, 51}, thickness = 0.5));
end AnnualSimulationSingleHouse;
