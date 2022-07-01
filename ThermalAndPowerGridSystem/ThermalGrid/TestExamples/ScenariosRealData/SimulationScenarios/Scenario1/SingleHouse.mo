within ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios.Scenario1;

model SingleHouse
extends Modelica.Icons.Package;
  import Modelica.Units.SI.AbsolutePressure;
  inner SystemSetup.AmbientConditions ambientConditions;

  parameter AbsolutePressure sinkPressure = 5e5;
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pump2(massFlowRate= 6e-3) annotation(
    Placement(visible = true, transformation(origin = {137, -29}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.coldTank coldTank(InitialLevel = 1600, TAmb(displayUnit = "K") = 313, maxHeight = 16.26, tankArea = 1153, tankVolume = 187500)  annotation(
    Placement(visible = true, transformation(origin = {-259, 45}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.hotTank hotTank(InitialLevel = 0.1, PTop(displayUnit = "Pa") = 1e5, TAmb(displayUnit = "K") = 323, maxHeight = 1.3, tankArea = 0.922, tankVolume = 1.2)  annotation(
    Placement(visible = true, transformation(origin = {61, -7}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Domestic2 domestic2(EnergyUsePerPersonPerYear = 7000000)  annotation(
    Placement(visible = true, transformation(origin = {237, 132}, extent = {{-33, -34}, {33, 34}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange2 annotation(
    Placement(visible = true, transformation(origin = {-45, -87}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Boiler boiler annotation(
    Placement(visible = true, transformation(origin = {-43, -157}, extent = {{-25, -23}, {25, 23}}, rotation = 0)));
  Modelica.Blocks.Sources.RealExpression fuelFlowRate(y = 0.00015)  annotation(
    Placement(visible = true, transformation(origin = {-123, -157}, extent = {{-29, -13}, {29, 13}}, rotation = 0)));
  Components.Pump pumpCold2(massFlowRate = 6e-3) annotation(
    Placement(visible = true, transformation(origin = {-179, -89}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.PortExchange1 portExchange1 annotation(
    Placement(visible = true, transformation(origin = {-49, 39}, extent = {{-27, -27}, {27, 27}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pumpCold1(massFlowRate = 6e-3)  annotation(
    Placement(visible = true, transformation(origin = {-176, 24}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Components.Pump pumpBypass(massFlowRate = 6e-3)  annotation(
    Placement(visible = true, transformation(origin = {-180, 160}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.bus scenarioBus annotation(
    Placement(visible = true, transformation(origin = {96, -192}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.BaseComponents.SolarCSP2 solarCSP2(NumberOfCollectors = 1, collectorEfficiency = 0.3)  annotation(
    Placement(visible = true, transformation(origin = {-48, 102}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Utilities.SolarIrradianceData solarIrradianceData annotation(
    Placement(visible = true, transformation(origin = {-130, 100}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
equation
  connect(hotTank.portB, pump2.inFlow) annotation(
    Line(points = {{99.5, -29}, {119, -29}}, color = {0, 170, 255}));
  connect(portExchange2.outFlow, hotTank.portA) annotation(
    Line(points = {{-20.7, -87}, {22.5, -87}, {22.5, 22}}, color = {0, 170, 255}));
  connect(portExchange2.thermalPortIn, boiler.heatOut) annotation(
    Line(points = {{-44, -86}, {-44, -132}, {-43.5, -132}, {-43.5, -182}}, color = {255, 0, 0}));
  connect(fuelFlowRate.y, boiler.FuelFlowRate) annotation(
    Line(points = {{-91, -157}, {-70, -157}}, color = {0, 0, 127}));
  connect(pumpCold2.outFlow, portExchange2.inFlow) annotation(
    Line(points = {{-160.38, -89}, {-69.38, -89}}, color = {0, 170, 255}));
  connect(coldTank.portB, pumpCold2.inFlow) annotation(
    Line(points = {{-222.7, 23.88}, {-222.7, -89.12}, {-197.7, -89.12}}, color = {0, 170, 255}));
  connect(coldTank.portB, pumpCold1.inFlow) annotation(
    Line(points = {{-222, 24}, {-194, 24}}, color = {0, 170, 255}));
  connect(pumpCold1.outFlow, portExchange1.inFlow) annotation(
    Line(points = {{-158, 24}, {-74, 24}, {-74, 38}}, color = {0, 170, 255}));
  connect(portExchange1.outFlow, hotTank.portA) annotation(
    Line(points = {{-24, 40}, {22, 40}, {22, 22}}, color = {0, 170, 255}));
  connect(coldTank.portB, pumpBypass.inFlow) annotation(
    Line(points = {{-222, 24}, {-222, 160}, {-197, 160}}, color = {0, 170, 255}));
  connect(pumpBypass.outFlow, hotTank.portA) annotation(
    Line(points = {{-162, 160}, {22, 160}, {22, 22}}, color = {0, 170, 255}));
  connect(scenarioBus.boilerControl, pumpCold2.pumpControl) annotation(
    Line(points = {{96, -192}, {-178, -192}, {-178, -72}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(scenarioBus.solarControl, pumpCold1.pumpControl) annotation(
    Line(points = {{96, -192}, {-176, -192}, {-176, 40}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(scenarioBus.bypassControl, pumpBypass.pumpControl) annotation(
    Line(points = {{96, -192}, {-180, -192}, {-180, 176}}, color = {255, 0, 255}, pattern = LinePattern.None));
  connect(hotTank.tempSensor, scenarioBus.supplyTempControl) annotation(
    Line(points = {{100, -18}, {96, -18}, {96, -192}}, color = {0, 0, 127}, pattern = LinePattern.None));
  connect(portExchange1.thermalPortIn, solarCSP2.heatOutput) annotation(
    Line(points = {{-48, 40}, {-48, 82}}, color = {255, 0, 0}));
  connect(solarIrradianceData.cspIrradiance, solarCSP2.directIrradiation) annotation(
    Line(points = {{-112, 100}, {-70, 100}}, color = {0, 0, 127}));
  connect(domestic2.outFlow, coldTank.portA) annotation(
    Line(points = {{274, 132}, {280, 132}, {280, 196}, {-296, 196}, {-296, 72}}, color = {0, 170, 255}));
  connect(pump2.outFlow, domestic2.inFlow) annotation(
    Line(points = {{156, -28}, {170, -28}, {170, 132}, {200, 132}}, color = {0, 170, 255}));
protected
  annotation(
    Diagram(coordinateSystem(extent = {{-300, -200}, {300, 200}}), graphics = {Text(lineThickness = 20.5, extent = {{-164, -8}, {-164, -8}}, textString = "text"), Text(origin = {-125, 175}, lineThickness = 20.5, extent = {{-41, 13}, {41, -13}}, textString = "bypassControl"), Text(origin = {-135, 53}, lineThickness = 20.5, extent = {{-37, 13}, {37, -13}}, textString = "solarControl"), Text(origin = {-131, -65}, lineThickness = 20.5, extent = {{-37, 13}, {37, -13}}, textString = "boilerControl"), Text(origin = {-254, -2}, lineThickness = 20.5, extent = {{-48, 20}, {48, -20}}, textString = "Cold Water Tank"), Text(origin = {62, -53}, lineThickness = 20.5, extent = {{-58, 21}, {58, -21}}, textString = "Hot Water Supply Tank"), Text(origin = {240, 90}, lineThickness = 20.5, extent = {{-66, 22}, {66, -22}}, textString = "Single House Space Heating"), Text(origin = {-128, 83}, lineThickness = 2.5, extent = {{-24, 7}, {24, -7}}, textString = "Solar Data")}),
    Icon(coordinateSystem(extent = {{-300, -200}, {300, 200}}), graphics = {Bitmap(origin = {3, 5}, extent = {{101, -85}, {-101, 85}}, imageSource = "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")}),
    experiment(StartTime = 0, StopTime = 86400, Tolerance = 1e-06, Interval = 172.8));
end SingleHouse;
