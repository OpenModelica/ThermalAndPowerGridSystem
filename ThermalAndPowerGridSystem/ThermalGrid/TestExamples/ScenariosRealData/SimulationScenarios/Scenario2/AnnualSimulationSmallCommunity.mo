within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario2;

model AnnualSimulationSmallCommunity
  extends Modelica.Icons.Example;
  ThermalAndPowerGridSystem.ThermalGrid.Utilities.KPI kpi annotation(
    Placement(visible = true, transformation(origin = {-80, -83}, extent = {{-16, -15}, {16, 15}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario2.SmallCommunity smallCommunity annotation(
    Placement(visible = true, transformation(origin = {-45, 35}, extent = {{-152, -90}, {152, 90}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario2.SmallCommunityControl CentralController annotation(
    Placement(visible = true, transformation(origin = {40, -37}, extent = {{-22, -21}, {22, 21}}, rotation = 0)));
equation
  connect(smallCommunity.scenarioBus, CentralController.controlBus) annotation(
    Line(points = {{-44, 11}, {-44, -80}, {40, -80}, {40, -58}}, color = {255, 204, 51}, thickness = 0.5));
  kpi.inputQ = smallCommunity.solarCSP1.directIrradiation * smallCommunity.solarCSP1.totalArea;
/*+ smallCommunity.solarCSP2.directIrradiation * smallCommunity.solarCSP2.totalArea*/
  kpi.outputQ = smallCommunity.solarCSP1.Q;
/*+ smallCommunity.solarCSP2.Q*/
  kpi.totalEnergyDemand = smallCommunity.residentialCommunity.EnergyUsePerPersonPerYear * smallCommunity.residentialCommunity.peopleData;
  kpi.userDemand = smallCommunity.residentialCommunity.userDemand;
  annotation(
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 8760),
    Diagram(graphics = {Text(origin = {-50, 64}, lineThickness = 2.5, extent = {{-40, 12}, {40, -12}}, textString = "Small Community Scenario"), Text(origin = {43, -6}, lineThickness = 2.5, extent = {{-27, 4}, {27, -4}}, textString = "Scenario Controller")}));
end AnnualSimulationSmallCommunity;
