within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios;

model AnnualSimulationSingleIndustry
extends Modelica.Icons.UnderConstruction;
  import Modelica.Units.SI.AbsolutePressure;
  inner SystemSetup.AmbientConditions ambientConditions;

  parameter AbsolutePressure sinkPressure = 5e5;
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange1 annotation(
    Placement(visible = true, transformation(origin = {-50, -24}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pumpCold(massFlowRate= 100) annotation(
    Placement(visible = true, transformation(origin = {-118, -24}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pump2(massFlowRate= 100) annotation(
    Placement(visible = true, transformation(origin = {143, -101}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.LinearValve linearValve1 annotation(
    Placement(visible = true, transformation(origin = {-278, 124}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.coldTank coldTank(InitialLevel = 25, TAmb(displayUnit = "K") = 313, tankVolume = 5000)  annotation(
    Placement(visible = true, transformation(origin = {-210, 4}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank hotTank(InitialLevel = 25, PTop(displayUnit = "Pa") = 2e5, TAmb(displayUnit = "K") = 353, tankVolume = 5000)  annotation(
    Placement(visible = true, transformation(origin = {48, -72}, extent = {{-46, -46}, {46, 46}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.SupplyPipe supplyPipe annotation(
    Placement(visible = true, transformation(origin = {189, -31}, extent = {{-27, -27}, {27, 27}}, rotation = 90)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.returnPipe returnPipe annotation(
    Placement(visible = true, transformation(origin = {5, 173}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.IndustrialHeat industrialHeat annotation(
    Placement(visible = true, transformation(origin = {240, 93}, extent = {{-36, -35}, {36, 35}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BaseComponents.SolarCSP solarCSP annotation(
    Placement(visible = true, transformation(origin = {-50, 86}, extent = {{-22, -20}, {22, 20}}, rotation = 0)));
equation
  connect(pumpCold.outFlow, portExchange1.inFlow) annotation(
    Line(points = {{-98, -24}, {-72, -24}}, color = {0, 170, 255}));
  connect(coldTank.portA, linearValve1.portB) annotation(
    Line(points = {{-258, 40}, {-258, 116}}, color = {0, 170, 255}));
  connect(coldTank.portB, pumpCold.inFlow) annotation(
    Line(points = {{-162, -24}, {-137, -24}}, color = {0, 170, 255}));
  connect(portExchange1.outFlow, hotTank.portA) annotation(
    Line(points = {{-28, -24}, {-3, -24}, {-3, -34}}, color = {0, 170, 255}));
  connect(hotTank.portB, pump2.inFlow) annotation(
    Line(points = {{99, -101}, {125, -101}}, color = {0, 170, 255}));
  connect(pump2.outFlow, supplyPipe.portA) annotation(
    Line(points = {{162, -101}, {190, -101}, {190, -60}}, color = {0, 170, 255}));
  connect(returnPipe.portA, linearValve1.portA) annotation(
    Line(points = {{-26, 174}, {-296, 174}, {-296, 116}}, color = {0, 170, 255}));
  connect(supplyPipe.portB, industrialHeat.inFlow) annotation(
    Line(points = {{190, -2}, {186, -2}, {186, 94}, {200, 94}}, color = {0, 170, 255}));
  connect(returnPipe.portB, industrialHeat.outFlow) annotation(
    Line(points = {{36, 174}, {288, 174}, {288, 94}, {280, 94}}, color = {0, 170, 255}));
  connect(solarCSP.heatOutput, portExchange1.thermalPortIn) annotation(
    Line(points = {{-50, 64}, {-50, -24}}, color = {255, 0, 0}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    experiment(StartTime = 0, StopTime = 500, Tolerance = 1e-06, Interval = 1));
end AnnualSimulationSingleIndustry;
