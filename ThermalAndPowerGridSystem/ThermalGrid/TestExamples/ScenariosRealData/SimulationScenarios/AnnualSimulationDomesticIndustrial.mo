within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios;

model AnnualSimulationDomesticIndustrial
extends Modelica.Icons.UnderConstruction;
  import Modelica.Units.SI.AbsolutePressure;
  inner SystemSetup.AmbientConditions ambientConditions;

  parameter AbsolutePressure sinkPressure = 5e5;
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange1 annotation(
    Placement(visible = true, transformation(origin = {-68, -26}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pumpCold(massFlowRate= 100) annotation(
    Placement(visible = true, transformation(origin = {-145, -53}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pump2(massFlowRate= 100) annotation(
    Placement(visible = true, transformation(origin = {101, -171}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.LinearValve linearValve1 annotation(
    Placement(visible = true, transformation(origin = {-266, 50}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.coldTank coldTank(InitialLevel = 25, TAmb(displayUnit = "K") = 313, tankVolume = 5000)  annotation(
    Placement(visible = true, transformation(origin = {-214, -32}, extent = {{-34, -34}, {34, 34}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank hotTank(InitialLevel = 25, PTop(displayUnit = "Pa") = 2e5, TAmb(displayUnit = "K") = 353, tankVolume = 5000)  annotation(
    Placement(visible = true, transformation(origin = {9, -151}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.industrialComplex industrialComplex(energyPerIndustry = 33472, industryNumber = 1000)  annotation(
    Placement(visible = true, transformation(origin = {217, -38}, extent = {{-39, -38}, {39, 38}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.hotPipelineSystem hotPipelineSystem annotation(
    Placement(visible = true, transformation(origin = {127, -99}, extent = {{-27, -27}, {27, 27}}, rotation = 90)));
  ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.hotPipelineSystem hotPipelineSystem2 annotation(
    Placement(visible = true, transformation(origin = {128, 40}, extent = {{-26, -26}, {26, 26}}, rotation = 90)));
  ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.coldPipelineSystem coldPipelineSystem annotation(
    Placement(visible = true, transformation(origin = {-45, 163}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.ResidentialCommunity residentialCommunity annotation(
    Placement(visible = true, transformation(origin = {218, 114}, extent = {{-42, -36}, {42, 36}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BaseComponents.SolarCSP2 solarCSP2 annotation(
    Placement(visible = true, transformation(origin = {-68, 42}, extent = {{-18, -16}, {18, 16}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Utilities.SolarIrradianceData solarIrradianceData annotation(
    Placement(visible = true, transformation(origin = {-132, 40}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
equation
  connect(coldTank.portA, linearValve1.portB) annotation(
    Line(points = {{-251, -4}, {-273, -4}, {-273, 31}}, color = {0, 170, 255}));
  connect(coldTank.portB, pumpCold.inFlow) annotation(
    Line(points = {{-177, -54}, {-156, -54}, {-156, -53}, {-159, -53}}, color = {0, 170, 255}));
  connect(portExchange1.outFlow, hotTank.portA) annotation(
    Line(points = {{-46, -26}, {-27, -26}, {-27, -124}}, color = {0, 170, 255}));
  connect(hotTank.portB, pump2.inFlow) annotation(
    Line(points = {{45, -172}, {79, -172}, {79, -171}, {87, -171}}, color = {0, 170, 255}));
  connect(hotPipelineSystem.portB, industrialComplex.inFlow) annotation(
    Line(points = {{126, -74}, {126, -38}, {174, -38}}, color = {0, 170, 255}));
  connect(industrialComplex.outFlow, hotPipelineSystem2.portA) annotation(
    Line(points = {{260, -37}, {292, -37}, {292, 11}, {128, 11}}, color = {0, 170, 255}));
  connect(hotPipelineSystem2.portB, residentialCommunity.inFlow) annotation(
    Line(points = {{128, 69}, {128, 114}, {172, 114}}, color = {0, 170, 255}));
  connect(residentialCommunity.outFlow, coldPipelineSystem.portB) annotation(
    Line(points = {{264, 114}, {290, 114}, {290, 163}, {-15, 163}}, color = {0, 170, 255}));
  connect(pump2.outFlow, hotPipelineSystem.portA) annotation(
    Line(points = {{116, -170}, {128, -170}, {128, -128}}, color = {0, 170, 255}));
  connect(pumpCold.outFlow, portExchange1.inFlow) annotation(
    Line(points = {{-130, -52}, {-90, -52}, {-90, -26}}, color = {0, 170, 255}));
  connect(coldPipelineSystem.portA, linearValve1.portA) annotation(
    Line(points = {{-74, 164}, {-274, 164}, {-274, 68}}, color = {0, 170, 255}));
  connect(solarCSP2.heatOutput, portExchange1.thermalPortIn) annotation(
    Line(points = {{-68, 24}, {-68, -26}}, color = {255, 0, 0}));
  connect(solarIrradianceData.cspIrradiance, solarCSP2.directIrradiation) annotation(
    Line(points = {{-117, 40}, {-90, 40}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}})),
    experiment(StartTime = 0, StopTime = 86400, Tolerance = 1e-06, Interval = 172.8));
end AnnualSimulationDomesticIndustrial;
