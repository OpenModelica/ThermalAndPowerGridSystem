within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario3;

model NetherlandsControl
  extends Modelica.Icons.Package;
  extends ThermalAndPowerGridSystem.ThermalGrid.Icons.Control;
  ThermalAndPowerGridSystem.ThermalGrid.Control.Scenario1Controller4 CentralController(T_DH = 363.15, T_DH_H = 368.15, T_DH_L = 358.15, T_DH_LL = 353.15) annotation(
    Placement(visible = true, transformation(origin = {1, 1}, extent = {{-51, -49}, {51, 49}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.bus controllerBus annotation(
    Placement(visible = true, transformation(origin = {0, -96}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -92}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(controllerBus.supplyTemperature, CentralController.supplyTemperature) annotation(
    Line(points = {{0, -96}, {94, -96}, {94, 84}, {26.5, 84}, {26.5, 55}}, color = {0, 0, 127}, pattern = LinePattern.None));
  connect(controllerBus.TEStemperature, CentralController.temperatureTES) annotation(
    Line(points = {{0, -96}, {-88, -96}, {-88, 86}, {-26, 86}, {-26, 55}}, color = {0, 0, 127}, pattern = LinePattern.None));
  connect(CentralController.solarOutletPumpControl, controllerBus.solarOutletPumpControl) annotation(
    Line(points = {{57, 27}, {74, 27}, {74, -96}, {0, -96}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(CentralController.outletPumpTEScontrol, controllerBus.outletPumpTEScontrol) annotation(
    Line(points = {{35, -53}, {36, -53}, {36, -74}, {0, -74}, {0, -96}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(CentralController.outletPumpColdTank2Control, controllerBus.outletPumpColdTank2Control) annotation(
    Line(points = {{-30, -53}, {-30, -74}, {0, -74}, {0, -96}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(CentralController.bypassValveControl, controllerBus.bypassValveControl) annotation(
    Line(points = {{-55, -22}, {-76, -22}, {-76, -96}, {0, -96}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(CentralController.coldWaterSupplyBoilerControl, controllerBus.coldWaterSuuplyBoilerControl) annotation(
    Line(points = {{-55, 28}, {-64, 28}, {-64, -60}, {0, -60}, {0, -96}}, color = {255, 0, 255}, pattern = LinePattern.None));

annotation(
    Diagram(graphics = {Text(origin = {33, 70}, lineThickness = 2.5, extent = {{-31, 8}, {31, -8}}, textString = "supplyTemperature"), Text(origin = {-33, 70}, lineThickness = 2.5, extent = {{-31, 8}, {31, -8}}, textString = "TES Temperature"), Text(origin = {-100, 29}, lineThickness = 2.5, extent = {{-38, 7}, {38, -7}}, textString = "Cold Water Supply Boiler Control"), Text(origin = {94, 28}, lineThickness = 2.5, extent = {{-32, 6}, {32, -6}}, textString = "Solar Outlet Pump Control"), Text(origin = {-93, -21}, lineThickness = 2.5, extent = {{-31, 3}, {31, -3}}, textString = "Bypass Valve Control"), Text(origin = {36, -62}, lineThickness = 2.5, extent = {{-22, 5}, {22, -5}}, textString = "TES Output Control"), Text(origin = {-34, -62}, lineThickness = 2.5, extent = {{-22, 5}, {22, -5}}, textString = "Cold Tank Control 2")}));
end NetherlandsControl;
