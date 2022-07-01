within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenarioTest;

model AnnualSimulationSmallCommunityTrial
  import Modelica.Units.SI.AbsolutePressure;
  inner SystemSetup.AmbientConditions ambientConditions;
  extends Modelica.Icons.Example;
  parameter AbsolutePressure sinkPressure = 3e5;
  parameter Real[12] cumDays = {31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
  Real days;
  /*hour, */
  Real mfr = 14;
  /*,mfr2*/
  //Real dummyOut;
  ThermalAndPowerGridSystem.ThermalGrid.Components.coldTank coldWaterTank(InitialLevel = 100, PTop(displayUnit = "bar"), tankArea = 3021, tankSurfaceArea = 1900, tankVolume = 30000) annotation(
    Placement(visible = true, transformation(origin = {-663, 103}, extent = {{-59, -59}, {59, 59}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange1 annotation(
    Placement(visible = true, transformation(origin = {-347, 35}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank hotWaterSupplyTank(InitialLevel = 6, PTop(displayUnit = "Pa"), TAmb(displayUnit = "K") = 323, tankArea = 146.4, tankSurfaceArea = 146.4, tankVolume = 1200) annotation(
    Placement(visible = true, transformation(origin = {58, 198}, extent = {{-58, -58}, {58, 58}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank TES(InitialLevel = 8, PTop(displayUnit = "Pa"), TAmb(displayUnit = "K") = 333, tankArea = 100, tankSurfaceArea = 100, tankVolume = 1000) annotation(
    Placement(visible = true, transformation(origin = {-209, -323}, extent = {{-55, -55}, {55, 55}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump outletPumpTES(massFlowRate = 7) annotation(
    Placement(visible = true, transformation(origin = {-32, -358}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump outletPumpSupplyTank(massFlowRate = 7) annotation(
    Placement(visible = true, transformation(origin = {225, 93}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  //Real dummyOut" Variable for debugging";
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange2 annotation(
    Placement(visible = true, transformation(origin = {-330, 246}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Boiler boiler annotation(
    Placement(visible = true, transformation(origin = {-326, 341}, extent = {{-38, -37}, {38, 37}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.hotPipelineSystem hotPipelineSystem annotation(
    Placement(visible = true, transformation(origin = {353, 95}, extent = {{-41, -31}, {41, 31}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.ResidentialCommunity residentialCommunity(delP = 2000000, peopleData = 1000) annotation(
    Placement(visible = true, transformation(origin = {599, 211}, extent = {{-61, -53}, {61, 53}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression FuelFlowRate(y = 0.15) annotation(
    Placement(visible = true, transformation(origin = {-457, 338}, extent = {{-51, -22}, {51, 22}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.LinearValve coldWaterSupply annotation(
    Placement(visible = true, transformation(origin = {-366, 160}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump outletPumpColdTank(massFlowRate = 7) annotation(
    Placement(visible = true, transformation(origin = {-520, 34}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange3 annotation(
    Placement(visible = true, transformation(origin = {-441, -271}, extent = {{-37, -37}, {37, 37}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.LinearValve inletValveTEShot annotation(
    Placement(visible = true, transformation(origin = {-331, -267}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump outletPumpColdTank2(massFlowRate = 14) annotation(
    Placement(visible = true, transformation(origin = {-531, -273}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.LinearValve solarOutletValve annotation(
    Placement(visible = true, transformation(origin = {-156, 46}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.LinearValve coldWaterSupplyBoiler annotation(
    Placement(visible = true, transformation(origin = {-463, 255}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BaseComponents.SolarCSP2 solarCSP2(NumberOfCollectors = 1000) annotation(
    Placement(visible = true, transformation(origin = {-439, -156}, extent = {{-31, -28}, {31, 28}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BaseComponents.SolarCSP2 solarCSP1(NumberOfCollectors = 1000) annotation(
    Placement(visible = true, transformation(origin = {-346, -50}, extent = {{-34, -30}, {34, 30}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Utilities.SolarIrradianceData solarIrradianceData annotation(
    Placement(visible = true, transformation(origin = {-687, -57}, extent = {{-51, -51}, {51, 51}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Utilities.KPI kpi annotation(
    Placement(visible = true, transformation(origin = {685, -377}, extent = {{-53, -49}, {53, 49}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Control.Scenario1Controller3 scenario1Controller3 annotation(
    Placement(visible = true, transformation(origin = {310, -233}, extent = {{-94, -87}, {94, 87}}, rotation = 0)));
equation
//dummyOut = ThermalAndPowerGridSystem.ThermalGrid.Functions.OMdebug(2, time, coldWaterTank.portB.pressure, hotWaterSupplyTank.portB.pressure, TES.portB.pressure, hotPipelineSystem.portB.pressure, outletPumpColdTank.inFlow.pressure);
//  hour = mod(div(time, 3600), 24);
  days = div(time, 3600 * 24);
//if days<[3] - 1e-08 then
//mfr2 =
//  if days < cumDays[1] - 1e-8 then
//    mfr = 14;
//  elseif days < cumDays[2] - 1e-8 then
//    mfr = 40;
//  elseif days < cumDays[3] - 1e-8 then
//    mfr = 90;
//  elseif days < cumDays[4] - 1e-8 then
//    mfr = 104;
//  elseif days < cumDays[5] - 1e-8 then
//    mfr = 134;
//if days < cumDays[6] - 1e-8 then
//    mfr = 100;
//    end if;
//  elseif days < cumDays[7] - 1e-8 then
//    mfr = 194;
//  elseif days < cumDays[8] - 1e-8 then
//    mfr = 224;
//  elseif days < cumDays[9] - 1e-8 then
//    mfr = 254;
//  elseif days < cumDays[10] - 1e-8 then
//    mfr = 284;
//  elseif days < cumDays[11] - 1e-8 then
//    mfr = 314;
//  elseif days < cumDays[12] - 1e-8 then
//    mfr = 344;
//  else
//    mfr = 14;
//  end if;
  connect(TES.portB, outletPumpTES.inFlow) annotation(
    Line(points = {{-148.5, -358.2}, {-61, -358.2}}, color = {0, 170, 255}));
  connect(hotWaterSupplyTank.portB, outletPumpSupplyTank.inFlow) annotation(
    Line(points = {{121.8, 160.88}, {156.3, 160.88}, {156.3, 93}, {197, 93}}, color = {0, 170, 255}));
//  dummyOut = ThermalAndPowerGridSystem.ThermalGrid.Functions.OMdebug(4, time, residentialCommunity.inFlow.pressure, residentialCommunity.inFlow.specificEnthalpy, residentialCommunity.outFlow.pressure, residentialCommunity.outFlow.specificEnthalpy, 0);
  connect(portExchange2.thermalPortIn, boiler.heatOut) annotation(
    Line(points = {{-329.44, 246}, {-327, 246}, {-327, 300}}, color = {255, 0, 0}));
  connect(portExchange2.outFlow, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-304.8, 246}, {-6.60002, 246}}, color = {0, 170, 255}));
  connect(outletPumpTES.outFlow, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-2.6, -358}, {-5.2, -358}, {-5.2, 246}}, color = {0, 170, 255}));
  connect(outletPumpSupplyTank.outFlow, hotPipelineSystem.portA) annotation(
    Line(points = {{253, 93}, {280.5, 93}, {280.5, 95}, {308, 95}}, color = {0, 170, 255}));
  connect(hotPipelineSystem.portB, residentialCommunity.inFlow) annotation(
    Line(points = {{398, 95}, {532.1, 95}, {532.1, 212}}, color = {0, 170, 255}));
  connect(FuelFlowRate.y, boiler.FuelFlowRate) annotation(
    Line(points = {{-401, 338}, {-408.4, 338}, {-408.4, 341}, {-367, 341}}, color = {0, 0, 127}));
  connect(coldWaterSupply.portB, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-336, 149}, {-5.91997, 149}, {-5.91997, 245.12}}, color = {0, 170, 255}));
  connect(coldWaterTank.portB, outletPumpColdTank.inFlow) annotation(
    Line(points = {{-598.1, 65.24}, {-549.2, 65.24}, {-549.2, 33.48}}, color = {0, 170, 255}));
  connect(outletPumpColdTank.outFlow, portExchange1.inFlow) annotation(
    Line(points = {{-490.6, 34}, {-373, 34}}, color = {0, 170, 255}));
  connect(portExchange3.outFlow, inletValveTEShot.portA) annotation(
    Line(points = {{-407.7, -271}, {-355.7, -271}, {-355.7, -277}}, color = {0, 170, 255}));
  connect(inletValveTEShot.portB, TES.portA) annotation(
    Line(points = {{-305.62, -276.18}, {-287.37, -276.18}, {-287.37, -278.18}, {-269.12, -278.18}}, color = {0, 170, 255}));
  connect(coldWaterTank.portB, outletPumpColdTank2.inFlow) annotation(
    Line(points = {{-598.1, 65.24}, {-559.1, 65.24}, {-559.1, -273.76}}, color = {0, 170, 255}));
  connect(outletPumpColdTank2.outFlow, portExchange3.inFlow) annotation(
    Line(points = {{-502.58, -273}, {-473.58, -273}, {-473.58, -272}}, color = {0, 170, 255}));
  connect(portExchange1.outFlow, solarOutletValve.portA) annotation(
    Line(points = {{-320.9, 35}, {-184.9, 35}}, color = {0, 170, 255}));
  connect(solarOutletValve.portB, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-127.8, 35.8}, {-5.8, 35.8}, {-5.8, 245.8}}, color = {0, 170, 255}));
  connect(portExchange2.inFlow, coldWaterSupplyBoiler.portB) annotation(
    Line(points = {{-355.2, 245.44}, {-436.2, 245.44}}, color = {0, 170, 255}));
  connect(coldWaterSupplyBoiler.portA, outletPumpColdTank.outFlow) annotation(
    Line(points = {{-489.68, 244.56}, {-489.68, 33.56}}, color = {0, 170, 255}));
  connect(outletPumpColdTank.outFlow, coldWaterSupply.portA) annotation(
    Line(points = {{-490, 34}, {-490, 148}, {-396, 148}}, color = {0, 170, 255}));
  connect(residentialCommunity.outFlow, coldWaterTank.portA) annotation(
    Line(points = {{666, 212}, {720, 212}, {720, 408}, {-728, 408}, {-728, 152}}, color = {0, 170, 255}));
  connect(portExchange3.thermalPortIn, solarCSP2.heatOutput) annotation(
    Line(points = {{-440, -270}, {-440, -226}, {-438, -226}, {-438, -186}}, color = {255, 0, 0}));
  connect(portExchange1.thermalPortIn, solarCSP1.heatOutput) annotation(
    Line(points = {{-346, 36}, {-345, 36}, {-345, -83}}, color = {255, 0, 0}));
  connect(solarIrradianceData.outputIrradiance, solarCSP1.directIrradiation) annotation(
    Line(points = {{-631, -57}, {-496, -57}, {-496, -54}, {-386, -54}}, color = {0, 0, 127}));
  kpi.inputQ = solarCSP1.directIrradiation * solarCSP1.totalArea + solarCSP2.directIrradiation * solarCSP2.totalArea;
  kpi.outputQ = solarCSP1.Q + solarCSP2.Q;
  kpi.totalEnergyDemand = residentialCommunity.EnergyUsePerPersonPerYear * residentialCommunity.peopleData;
  kpi.userDemand = residentialCommunity.userDemand;
  connect(hotWaterSupplyTank.tempSensor, scenario1Controller3.supplyTemperature) annotation(
    Line(points = {{122, 180}, {140, 180}, {140, -66}, {358, -66}, {358, -138}}, color = {0, 0, 127}));
  connect(scenario1Controller3.solarOutletValveControl, solarOutletValve.valveSwitch) annotation(
    Line(points = {{414, -186}, {466, -186}, {466, 22}, {-156, 22}}, color = {255, 0, 255}));
  connect(scenario1Controller3.bypassValveControl, coldWaterSupply.valveSwitch) annotation(
    Line(points = {{206, -274}, {44, -274}, {44, 114}, {-366, 114}, {-366, 136}}, color = {255, 0, 255}));
  connect(scenario1Controller3.outletPumpColdTankControl, outletPumpColdTank.pumpControl) annotation(
    Line(points = {{414, -274}, {472, -274}, {472, 42}, {-46, 42}, {-46, -14}, {-520, -14}, {-520, 62}}, color = {255, 0, 255}));
  connect(scenario1Controller3.outletPumpColdTank2Control, outletPumpColdTank2.pumpControl) annotation(
    Line(points = {{254, -328}, {254, -420}, {-530, -420}, {-530, -246}}, color = {255, 0, 255}));
  connect(scenario1Controller3.outletPumpTEScontrol, outletPumpTES.pumpControl) annotation(
    Line(points = {{372, -328}, {368, -328}, {368, -402}, {-32, -402}, {-32, -330}}, color = {255, 0, 255}));
  connect(scenario1Controller3.coldWaterSupplyBoilerControl, coldWaterSupplyBoiler.valveSwitch) annotation(
    Line(points = {{206, -184}, {-204, -184}, {-204, 194}, {-462, 194}, {-462, 232}}, color = {255, 0, 255}));
  connect(solarIrradianceData.outputIrradiance, solarCSP2.directIrradiation) annotation(
    Line(points = {{-631, -57}, {-536, -57}, {-536, -160}, {-476, -160}}, color = {0, 0, 127}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-750, -430}, {750, 430}})),
    Icon(coordinateSystem(extent = {{-750, -430}, {750, 430}})),
    experiment(StartTime = 0, StopTime = 31536000, Tolerance = 1e-06, Interval = 63452.7));
end AnnualSimulationSmallCommunityTrial;
