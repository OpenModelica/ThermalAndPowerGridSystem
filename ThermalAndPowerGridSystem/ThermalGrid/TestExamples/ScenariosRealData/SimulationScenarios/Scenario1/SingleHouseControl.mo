within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario1;

model SingleHouseControl
extends Modelica.Icons.Package;
  ThermalAndPowerGridSystem.ThermalGrid.Control.SingleHouseController CentralController annotation(
    Placement(visible = true, transformation(origin = {0, 48}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.bus ControllerBus annotation(
    Placement(visible = true, transformation(origin = {0, -94}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -94}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(CentralController.pumpCold2Control, ControllerBus.boilerControl) annotation(
    Line(points = {{22, 38}, {30, 38}, {30, -56}, {0, -56}, {0, -94}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(CentralController.pumpBypassControl, ControllerBus.bypassControl) annotation(
    Line(points = {{22, 48}, {42, 48}, {42, -74}, {0, -74}, {0, -94}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(CentralController.pumpColdControl, ControllerBus.solarControl) annotation(
    Line(points = {{22, 60}, {56, 60}, {56, -94}, {0, -94}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(ControllerBus.supplyTempControl, CentralController.supplyTemperature) annotation(
    Line(points = {{0, -94}, {-22, -94}, {-22, 48}}, color = {0, 0, 127}, pattern = LinePattern.None));

annotation(
    Icon(graphics = {Bitmap(origin = {4, 5}, extent = {{130, -97}, {-130, 97}}, imageSource = "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")}),
    Diagram(graphics = {Text(origin = {-54, 47}, lineThickness = 2.5, extent = {{-24, 7}, {24, -7}}, textString = "Supply Temperature"), Text(origin = {47, 61}, lineThickness = 2.5, extent = {{-19, 5}, {19, -5}}, textString = "Solar Control"), Text(origin = {47, 37}, lineThickness = 2.5, extent = {{-19, 5}, {19, -5}}, textString = "Boiler Control"), Text(origin = {49, 49}, lineThickness = 2.5, extent = {{-21, 5}, {21, -5}}, textString = "Bypass Control")}));
end SingleHouseControl;
