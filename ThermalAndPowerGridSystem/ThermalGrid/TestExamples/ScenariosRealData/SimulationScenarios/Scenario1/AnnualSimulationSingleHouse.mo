within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario1;

model AnnualSimulationSingleHouse
  extends Modelica.Icons.Example;
  ThermalAndPowerGridSystem.ThermalGrid.Utilities.KPI kpi annotation(
    Placement(visible = true, transformation(origin = {-80, -84}, extent = {{-16, -14}, {16, 14}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario1.SingleHouseControl singleHouseControl annotation(
    Placement(visible = true, transformation(origin = {51, -5}, extent = {{-27, -25}, {27, 25}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario1.SingleHouse singleHouse annotation(
    Placement(visible = true, transformation(origin = {-45, 36}, extent = {{-81, -52}, {81, 52}}, rotation = 0)));
equation
  kpi.inputQ = singleHouse.solarCSP2.directIrradiation*singleHouse.solarCSP2.totalArea;
  kpi.outputQ = singleHouse.solarCSP2.Q;
  kpi.totalEnergyDemand = singleHouse.domestic2.EnergyUsePerPersonPerYear;
  kpi.userDemand = singleHouse.domestic2.userDemand;
  connect(singleHouse.scenarioBus, singleHouseControl.ControllerBus) annotation(
    Line(points = {{-45, 7}, {-45, -60}, {51, -60}, {51, -28.5}}, color = {255, 204, 51}, thickness = 0.5));
  annotation(
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 8760),
    Diagram(graphics = {Text(origin = {-46, 70}, lineThickness = 2.5, extent = {{-32, 14}, {32, -14}}, textString = "Single House Scenario"), Text(origin = {50, 28}, lineThickness = 2.5, extent = {{-32, 14}, {32, -14}}, textString = "Single House Control")}));
end AnnualSimulationSingleHouse;
