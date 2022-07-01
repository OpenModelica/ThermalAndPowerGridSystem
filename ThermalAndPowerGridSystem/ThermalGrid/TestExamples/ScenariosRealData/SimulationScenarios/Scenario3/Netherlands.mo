within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario3;

model Netherlands
 extends Modelica.Icons.Package;
 extends ThermalAndPowerGridSystem.ThermalGrid.Icons.Netherlands;
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump outletPumpTES(massFlowRate = 220000) annotation(
    Placement(visible = true, transformation(origin = {-22, -314}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank TES(InitialLevel = 20, PTop(displayUnit = "Pa"), TAmb(displayUnit = "K") = 323, tankArea = 10e5, tankSurfaceArea = 3021, tankVolume = 20e10) annotation(
    Placement(visible = true, transformation(origin = {-131, -353}, extent = {{-79, -79}, {79, 79}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange3 annotation(
    Placement(visible = true, transformation(origin = {-339, -265}, extent = {{-37, -37}, {37, 37}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BaseComponents.SolarCSP2 solarCSP2(NumberOfCollectors = 80000000, SolarCapacity = 100) annotation(
    Placement(visible = true, transformation(origin = {-337, -374}, extent = {{-49, -42}, {49, 42}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression FuelFlowRate(y = 6700) annotation(
    Placement(visible = true, transformation(origin = {-457, 338}, extent = {{-51, -22}, {51, 22}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank hotWaterSupplyTank(InitialLevel = 100, PTop(displayUnit = "Pa"), TAmb(displayUnit = "K") = 358.15, tankArea = 10e5, tankSurfaceArea = 10e5, tankVolume = 10e10) annotation(
    Placement(visible = true, transformation(origin = {60, 132}, extent = {{-58, -58}, {58, 58}}, rotation = 0)));
  Components.PortExchange1 portExchange2 annotation(
    Placement(visible = true, transformation(origin = {-330, 246}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.coldTank coldWaterTank(InitialLevel = 10e5, PTop(displayUnit = "bar"), tankArea = 10e5, tankSurfaceArea = 1, tankVolume = 10e10) annotation(
    Placement(visible = true, transformation(origin = {-673, 185}, extent = {{-59, -59}, {59, 59}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Utilities.SolarIrradianceData solarIrradianceData1(solarIrradianceData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/DirectSolarIrradiance.txt")) annotation(
    Placement(visible = true, transformation(origin = {-708, -100}, extent = {{-42, -42}, {42, 42}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BaseComponents.SolarCSP2 solarCSP1(NumberOfCollectors = 1900000) annotation(
    Placement(visible = true, transformation(origin = {-341, -94}, extent = {{-43, -44}, {43, 44}}, rotation = 0)));
  Components.PortExchange1 portExchange1 annotation(
    Placement(visible = true, transformation(origin = {-347, 35}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  Components.Boiler boiler annotation(
    Placement(visible = true, transformation(origin = {-326, 341}, extent = {{-38, -37}, {38, 37}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump outletPumpColdTank2(massFlowRate = 220000) annotation(
    Placement(visible = true, transformation(origin = {-523, -273}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump outletPumpSupplyTank(massFlowRate = 220000) annotation(
    Placement(visible = true, transformation(origin = {199, 95}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.SpaceHeating spaceHeating annotation(
    Placement(visible = true, transformation(origin = {509, 96}, extent = {{-71, -74}, {71, 74}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Utilities.UserDemandData userDemandData annotation(
    Placement(visible = true, transformation(origin = {340, 46}, extent = {{-44, -44}, {44, 44}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump coldWaterSupplyBoiler(massFlowRate = 220000) annotation(
    Placement(visible = true, transformation(origin = {-464, 244}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump coldWaterSupply(massFlowRate = 220000) annotation(
    Placement(visible = true, transformation(origin = {-447, 147}, extent = {{-31, -31}, {31, 31}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump solarOutletPump(massFlowRate = 220000) annotation(
    Placement(visible = true, transformation(origin = {-447, 35}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.bus scenarioBus annotation(
    Placement(visible = true, transformation(origin = {272, -413}, extent = {{-80, -69}, {80, 69}}, rotation = 0), iconTransformation(origin = {-2, -108}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  connect(outletPumpColdTank2.outFlow, portExchange3.inFlow) annotation(
    Line(points = {{-495, -273}, {-372, -273}, {-372, -266}}, color = {0, 170, 255}));
 connect(solarIrradianceData1.cspIrradiance, solarCSP1.directIrradiation) annotation(
    Line(points = {{-662, -100}, {-552.5, -100}, {-552.5, -99}, {-392, -99}}, color = {0, 0, 127}));
  connect(hotWaterSupplyTank.portB, outletPumpSupplyTank.inFlow) annotation(
    Line(points = {{124, 95}, {171, 95}}, color = {0, 170, 255}));
 connect(solarIrradianceData1.cspIrradiance, solarCSP2.directIrradiation) annotation(
    Line(points = {{-662, -100}, {-604, -100}, {-604, -379}, {-395, -379}}, color = {0, 0, 127}));
  connect(portExchange2.outFlow, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-304.8, 246}, {-3.7, 246}, {-3.7, 180}, {-4, 180}}, color = {0, 170, 255}));
  connect(coldWaterTank.portB, outletPumpColdTank2.inFlow) annotation(
    Line(points = {{-608, 147}, {-551, 147}, {-551, -273}}, color = {0, 170, 255}));
 connect(solarCSP2.heatOutput, portExchange3.thermalPortIn) annotation(
    Line(points = {{-336, -420}, {-336, -342.5}, {-338, -342.5}, {-338, -265}}, color = {255, 0, 0}));
  connect(FuelFlowRate.y, boiler.FuelFlowRate) annotation(
    Line(points = {{-401, 338}, {-408.4, 338}, {-408.4, 341}, {-367, 341}}, color = {0, 0, 127}));
  connect(outletPumpTES.outFlow, hotWaterSupplyTank.portA) annotation(
    Line(points = {{7, -314}, {-4, -314}, {-4, 180}}, color = {0, 170, 255}));
  connect(portExchange2.thermalPortIn, boiler.heatOut) annotation(
    Line(points = {{-329.44, 246}, {-327, 246}, {-327, 300}}, color = {255, 0, 0}));
  connect(outletPumpSupplyTank.outFlow, spaceHeating.inFlow) annotation(
    Line(points = {{227, 95}, {272, 95}, {272, 96}, {431, 96}}, color = {0, 170, 255}));
  connect(spaceHeating.outFlow, coldWaterTank.portA) annotation(
    Line(points = {{587, 96}, {614, 96}, {614, 410}, {-738, 410}, {-738, 233}}, color = {0, 170, 255}));
  connect(userDemandData.userDemand, spaceHeating.heatDemand) annotation(
    Line(points = {{388, 46}, {424, 46}}, color = {0, 0, 127}));
 connect(solarCSP1.heatOutput, portExchange1.thermalPortIn) annotation(
    Line(points = {{-340, -142}, {-346, -142}, {-346, 36}}, color = {255, 0, 0}));
  connect(portExchange2.inFlow, coldWaterSupplyBoiler.outFlow) annotation(
    Line(points = {{-356, 246}, {-432, 246}, {-432, 244}}, color = {0, 170, 255}));
  connect(coldWaterSupplyBoiler.inFlow, coldWaterTank.portB) annotation(
    Line(points = {{-494, 244}, {-552, 244}, {-552, 147}, {-608, 147}}, color = {0, 170, 255}));
  connect(coldWaterTank.portB, coldWaterSupply.inFlow) annotation(
    Line(points = {{-608, 147}, {-477, 147}}, color = {0, 170, 255}));
  connect(coldWaterSupply.outFlow, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-417, 147}, {-4, 147}, {-4, 180}}, color = {0, 170, 255}));
  connect(coldWaterTank.portB, solarOutletPump.inFlow) annotation(
    Line(points = {{-608, 147}, {-552, 147}, {-552, 33.5}, {-478, 33.5}, {-478, 36}}, color = {0, 170, 255}));
  connect(solarOutletPump.outFlow, portExchange1.inFlow) annotation(
    Line(points = {{-414, 36}, {-370, 36}, {-370, 34}, {-374, 34}}, color = {0, 170, 255}));
  connect(portExchange1.outFlow, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-320, 36}, {-4, 36}, {-4, 180}}, color = {0, 170, 255}));
  connect(portExchange3.outFlow, TES.portA) annotation(
    Line(points = {{-306, -265}, {-218, -265}, {-218, -288}}, color = {0, 170, 255}));
 connect(hotWaterSupplyTank.tempSensor, scenarioBus.supplyTemperature) annotation(
    Line(points = {{124, 114}, {154, 114}, {154, -344}, {272, -344}, {272, -413}}, color = {0, 0, 127}));
 connect(TES.tempSensor, scenarioBus.TEStemperature) annotation(
    Line(points = {{-44, -376}, {32, -376}, {32, -344}, {272, -344}, {272, -413}}, color = {0, 0, 127}));
 connect(scenarioBus.solarOutletPumpControl, solarOutletPump.pumpControl) annotation(
    Line(points = {{272, -413}, {358, -413}, {358, -36}, {-51, -36}, {-51, 66}, {-446, 66}}, color = {255, 0, 255}, pattern = LinePattern.None));
 connect(scenarioBus.outletPumpTEScontrol, outletPumpTES.pumpControl) annotation(
    Line(points = {{272, -413}, {288, -413}, {288, -286}, {-21, -286}}, color = {255, 0, 255}, pattern = LinePattern.None));
 connect(scenarioBus.outletPumpColdTank2Control, outletPumpColdTank2.pumpControl) annotation(
    Line(points = {{272, -413}, {72, -413}, {72, -200}, {-522, -200}, {-522, -246}}, color = {255, 0, 255}, pattern = LinePattern.None));
 connect(scenarioBus.bypassValveControl, coldWaterSupply.pumpControl) annotation(
    Line(points = {{272, -413}, {236, -413}, {236, -146}, {-114, -146}, {-114, 176}, {-446, 176}}, color = {255, 0, 255}, pattern = LinePattern.None));
 connect(scenarioBus.coldWaterSuuplyBoilerControl, coldWaterSupplyBoiler.pumpControl) annotation(
    Line(points = {{272, -413}, {262, -413}, {262, 274}, {-464, 274}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(TES.portB, outletPumpTES.inFlow) annotation(
    Line(points = {{-44, -404}, {-50, -404}, {-50, -314}}, color = {0, 170, 255}));
  annotation(
    Diagram(coordinateSystem(extent = {{-750, -430}, {750, 430}}), graphics = {Text(origin = {-674, 99}, lineThickness = 2.5, extent = {{-106, 33}, {106, -33}}, textString = "Cold Water Tank"), Text(origin = {-487, -403}, lineThickness = 2.5, extent = {{-89, 37}, {89, -37}}, textString = "Solar Field 2"), Text(origin = {-337, -167}, lineThickness = 2.5, extent = {{-89, 37}, {89, -37}}, textString = "Solar Field 1"), Text(origin = {63, 214}, lineThickness = 2.5, extent = {{-137, 32}, {137, -32}}, textString = "Hot Water Supply Tank"), Text(origin = {556, -14}, lineThickness = 2.5, extent = {{-140, 26}, {140, -26}}, textString = "Country Space Heating"), Text(origin = {-137, -232}, lineThickness = 2.5, extent = {{-33, 20}, {33, -20}}, textString = "TES")}),
    Icon(coordinateSystem(extent = {{-750, -430}, {750, 430}})),
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 3600));
end Netherlands;
