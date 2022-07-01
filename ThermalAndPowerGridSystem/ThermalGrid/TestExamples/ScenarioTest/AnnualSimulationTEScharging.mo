within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenarioTest;

model AnnualSimulationTEScharging
  import Modelica.Units.SI.AbsolutePressure;
  inner SystemSetup.AmbientConditions ambientConditions;
  extends Modelica.Icons.Example;
  parameter AbsolutePressure sinkPressure = 3e5;
  parameter Real[12] cumDays = {31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};

  ThermalAndPowerGridSystem.ThermalGrid.Components.coldTank coldWaterTank(InitialLevel = 80, PTop(displayUnit = "bar"), tankArea = 3021, tankSurfaceArea = 3021, tankVolume = 112500 * 1.5) annotation(
    Placement(visible = true, transformation(origin = {-677, -11}, extent = {{-59, -59}, {59, 59}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange1 annotation(
    Placement(visible = true, transformation(origin = {-353, -39}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank hotWaterSupplyTank(InitialLevel = 7, PTop(displayUnit = "Pa"), TAmb(displayUnit = "K") = 323, tankArea = 146.4, tankSurfaceArea = 146.4, tankVolume = 1200) annotation(
    Placement(visible = true, transformation(origin = {46, 118}, extent = {{-58, -58}, {58, 58}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank TES(InitialLevel = 5, PTop(displayUnit = "Pa"), TAmb(displayUnit = "degC") = 343, tankArea = 302, tankSurfaceArea = 302, tankVolume = 112500) annotation(
    Placement(visible = true, transformation(origin = {-177, -233}, extent = {{-55, -55}, {55, 55}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump outletPumpTES(massFlowRate = 7) annotation(
    Placement(visible = true, transformation(origin = {-44, -268}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Sensors.TemperatureSensor tSensorSupplyTank annotation(
    Placement(visible = true, transformation(origin = {104, 196}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump outletPumpSupplyTank(massFlowRate = 7) annotation(
    Placement(visible = true, transformation(origin = {213, 13}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.LinearValve inletValveTEShot annotation(
    Placement(visible = true, transformation(origin = {-281, -99}, extent = {{-27, -27}, {27, 27}}, rotation = -90)));
  //Real dummyOut" Variable for debugging";
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange2 annotation(
    Placement(visible = true, transformation(origin = {-340, 166}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Control.Scenario1Controller CentralController(thresholdPercentage = 2) annotation(
    Placement(visible = true, transformation(origin = {268, -221}, extent = {{-56, -53}, {56, 53}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Boiler boiler annotation(
    Placement(visible = true, transformation(origin = {-338, 265}, extent = {{-38, -37}, {38, 37}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.hotPipelineSystem hotPipelineSystem annotation(
    Placement(visible = true, transformation(origin = {449, 11}, extent = {{-41, -31}, {41, 31}}, rotation = 0)));
  CompoundComponents.ResidentialCommunity residentialCommunity(delP = 2000000, peopleData = 1000) annotation(
    Placement(visible = true, transformation(origin = {587, 131}, extent = {{-61, -53}, {61, 53}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression FuelFlowRate(y = 0.15) annotation(
    Placement(visible = true, transformation(origin = {-519, 266}, extent = {{-51, -22}, {51, 22}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump coldWaterSupplyBoiler(massFlowRate = 7) annotation(
    Placement(visible = true, transformation(origin = {-453, 163}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump solarOutletValve(massFlowRate = 7) annotation(
    Placement(visible = true, transformation(origin = {-163, -31}, extent = {{-29, -29}, {29, 29}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump outletPumpColdTank(massFlowRate = 14)  annotation(
    Placement(visible = true, transformation(origin = {-520, -50}, extent = {{-36, -36}, {36, 36}}, rotation = 0)));
  Components.LinearValve coldWaterSupply annotation(
    Placement(visible = true, transformation(origin = {-416, 60}, extent = {{-32, -32}, {32, 32}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BaseComponents.SolarCSP solarCSP annotation(
    Placement(visible = true, transformation(origin = {-350, -167}, extent = {{-42, -37}, {42, 37}}, rotation = 0)));
equation
 
  connect(hotWaterSupplyTank.portB, tSensorSupplyTank.tSensorInput) annotation(
    Line(points = {{110, 81}, {97, 81}, {97, 210}}, color = {0, 170, 255}));
  connect(TES.portB, outletPumpTES.inFlow) annotation(
    Line(points = {{-116.5, -268}, {-73, -268}}, color = {0, 170, 255}));
  connect(hotWaterSupplyTank.portB, outletPumpSupplyTank.inFlow) annotation(
    Line(points = {{110, 81}, {144.5, 81}, {144.5, 13}, {185, 13}}, color = {0, 170, 255}));
  connect(TES.portA, inletValveTEShot.portB) annotation(
    Line(points = {{-237.5, -188}, {-290, -188}, {-290, -124}}, color = {0, 170, 255}));
  connect(portExchange1.outFlow, inletValveTEShot.portA) annotation(
    Line(points = {{-327, -39}, {-291, -39}, {-291, -74}}, color = {0, 170, 255}));
  connect(portExchange2.thermalPortIn, boiler.heatOut) annotation(
    Line(points = {{-340, 166}, {-339, 166}, {-339, 224}}, color = {255, 0, 0}));
  connect(portExchange2.outFlow, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-314, 166}, {-18, 166}}, color = {0, 170, 255}));
  connect(tSensorSupplyTank.componentTemperatureOP, CentralController.supplyTemperature) annotation(
    Line(points = {{107, 210}, {107, -124}, {296, -124}, {296, -162}}, color = {0, 0, 127}));
  connect(outletPumpTES.outFlow, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-15, -268}, {-18, -268}, {-18, 166}}, color = {0, 170, 255}));
  connect(CentralController.outletPumpTEScontrol, outletPumpTES.pumpControl) annotation(
    Line(points = {{268, -280}, {268, -292}, {14, -292}, {14, -240}, {-43, -240}}, color = {255, 0, 255}));
  connect(CentralController.inletValveTEScontrol, inletValveTEShot.valveSwitch) annotation(
    Line(points = {{330, -246}, {388, -246}, {388, -338}, {-302, -338}, {-302, -100}}, color = {255, 0, 255}));
  connect(outletPumpSupplyTank.outFlow, hotPipelineSystem.portA) annotation(
    Line(points = {{241, 13}, {322.5, 13}, {322.5, 11}, {404, 11}}, color = {0, 170, 255}));
  connect(hotPipelineSystem.portB, residentialCommunity.inFlow) annotation(
    Line(points = {{494, 11}, {520, 11}, {520, 132}}, color = {0, 170, 255}));
  connect(FuelFlowRate.y, boiler.FuelFlowRate) annotation(
    Line(points = {{-463, 266}, {-378, 266}}, color = {0, 0, 127}));
  connect(coldWaterSupplyBoiler.outFlow, portExchange2.inFlow) annotation(
    Line(points = {{-427, 163}, {-366, 163}, {-366, 166}}, color = {0, 170, 255}));
  connect(portExchange1.outFlow, solarOutletValve.inFlow) annotation(
    Line(points = {{-327, -39}, {-247.5, -39}, {-247.5, -31}, {-191, -31}}, color = {0, 170, 255}));
  connect(solarOutletValve.outFlow, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-135, -31}, {-18, -31}, {-18, 166}}, color = {0, 170, 255}));
  connect(outletPumpColdTank.outFlow, coldWaterSupplyBoiler.inFlow) annotation(
    Line(points = {{-484, -50}, {-478, -50}, {-478, 164}}, color = {0, 170, 255}));
  connect(outletPumpColdTank.outFlow, portExchange1.inFlow) annotation(
    Line(points = {{-484, -50}, {-379, -50}, {-379, -40}}, color = {0, 170, 255}));
  connect(CentralController.coldWaterSupplyBoilerControl, coldWaterSupplyBoiler.pumpControl) annotation(
    Line(points = {{206, -192}, {-64, -192}, {-64, 188}, {-452, 188}}, color = {255, 0, 255}));
  connect(CentralController.solarOutletValveControl, solarOutletValve.pumpControl) annotation(
    Line(points = {{330, -192}, {382, -192}, {382, -34}, {122, -34}, {122, -4}, {-162, -4}}, color = {255, 0, 255}));
  connect(residentialCommunity.outFlow, coldWaterTank.portA) annotation(
    Line(points = {{654, 132}, {698, 132}, {698, 384}, {-742, 384}, {-742, 37}}, color = {0, 170, 255}));
  connect(CentralController.bypassValveControl, coldWaterSupply.valveSwitch) annotation(
    Line(points = {{206, -246}, {84, -246}, {84, -372}, {-416, -372}, {-416, 36}}, color = {255, 0, 255}));
  connect(outletPumpColdTank.outFlow, coldWaterSupply.portA) annotation(
    Line(points = {{-484, -50}, {-478, -50}, {-478, 48}, {-446, 48}}, color = {0, 170, 255}));
  connect(coldWaterTank.portB, outletPumpColdTank.inFlow) annotation(
    Line(points = {{-612, -49}, {-554, -49}, {-554, -50}}, color = {0, 170, 255}));
  connect(coldWaterSupply.portB, hotWaterSupplyTank.portA) annotation(
    Line(points = {{-386, 50}, {-18, 50}, {-18, 166}}, color = {0, 170, 255}));
  connect(TES.tempSensor, CentralController.TESTemperature) annotation(
    Line(points = {{-116, -250}, {-96, -250}, {-96, -144}, {232, -144}, {232, -162}}, color = {0, 0, 127}));
  connect(solarCSP.heatOutput, portExchange1.thermalPortIn) annotation(
    Line(points = {{-349, -208}, {-349, -131}, {-352, -131}, {-352, -38}}, color = {255, 0, 0}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-750, -400}, {750, 400}})),
    Icon(coordinateSystem(extent = {{-750, -400}, {750, 400}})),
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 63452.7));
end AnnualSimulationTEScharging;
