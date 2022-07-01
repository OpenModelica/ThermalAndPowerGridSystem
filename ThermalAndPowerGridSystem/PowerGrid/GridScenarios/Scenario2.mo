within ThermalAndPowerGridSystem.PowerGrid.GridScenarios;

model Scenario2
  extends Modelica.Icons.Example;
  ThermalAndPowerGridSystem.PowerGrid.Utilities.WindPowerData windPowerData(airDensity = Scenario2Parameters.airDensity, windSpeedData = Scenario2Parameters.windSpeedData)  annotation(
    Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.WindFarm windFarm(TurbineGenrationEfficiency = Scenario2Parameters.TurbineGenrationEfficiency, numberOfTurbines = Scenario2Parameters.numberOfTurbines, turbineRotorRadius = Scenario2Parameters.turbineRotorRadius, windGeneratedPowerLimit = Scenario2Parameters.windGeneratedPowerLimit)  annotation(
    Placement(visible = true, transformation(origin = {-50, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.SolarFarm SolarFarm(PvGenerationEfficiency = Scenario2Parameters.PvGenerationEfficiency, numberofPvPanels = Scenario2Parameters.numberofPvPanels, pvSurfaceArea = Scenario2Parameters.pvSurfaceArea)  annotation(
    Placement(visible = true, transformation(origin = {-50, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.PowerManagementSystem powerManagementSystem(solarGenCost = Scenario2Parameters.solarGenCost, windGenCost = Scenario2Parameters.windGenCost, energyStorageCost = Scenario2Parameters.energyStorageCost, dosmesticDemandCost = Scenario2Parameters.dosmesticDemandCost, chargingStationCost = Scenario2Parameters.chargingStationCost, tndEfficiency = Scenario2Parameters.tndEfficiency, V = Scenario2Parameters.V, storageSupplyPowerLimit = Scenario2Parameters.storageSupplyPowerLimit) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.DomesticConsumer domesticConsumer(domesticDemandData = Scenario2Parameters.domesticDemandData)  annotation(
    Placement(visible = true, transformation(origin = {70, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.ChargingStation chargingStation(bikeChargingDuration = Scenario2Parameters.bikeChargingDuration, carChargingDuration = Scenario2Parameters.carChargingDuration, evBikeCapacity = Scenario2Parameters.evBikeCapacity, evBikeChargingRating = Scenario2Parameters.evBikeChargingRating, evCarCapacity = Scenario2Parameters.evCarCapacity, evCarChargingRating = Scenario2Parameters.evCarChargingRating, maxNumberOfBikePerChargingStation = Scenario2Parameters.maxNumberOfBikePerChargingStation, maxNumberOfCarPerChargingStation = Scenario2Parameters.maxNumberOfCarPerChargingStation, minNumberOfBikePerChargingStation = Scenario2Parameters.minNumberOfBikePerChargingStation, minNumberOfCarPerChargingStation = Scenario2Parameters.minNumberOfCarPerChargingStation, numberOfChargingStation = Scenario2Parameters.numberOfChargingStation)  annotation(
    Placement(visible = true, transformation(origin = {70, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.EnergyStorage energyStorage(maxEnergyPercentage = Scenario2Parameters.maxEnergyPercentage, minEnergyPercentage = Scenario2Parameters.minEnergyPercentage, storageCapacity = Scenario2Parameters.storageCapacity)  annotation(
    Placement(visible = true, transformation(origin = {-20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.ConventionalGrid conventionalGrid annotation(
    Placement(visible = true, transformation(origin = {20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.Kpi kpi annotation(
    Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Utilities.SolarIrradianceData solarIrradianceData(solarIrradianceData = Scenario2Parameters.solarIrradianceData,pvTiltAngle = Scenario2Parameters.pvTiltAngle) annotation(
    Placement(visible = true, transformation(origin = {-90, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Utilities.SystemParameters Scenario2Parameters(airDensity(displayUnit = "kg/m3"), domesticDemandData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/GroupOfHousesElectricityDemand.txt"), solarGenerationDataFile = "0", windGenerationDataFile = "0")  annotation(
    Placement(visible = true, transformation(origin = {40, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(windPowerData.windOutputPower, windFarm.windPowerPerArea) annotation(
    Line(points = {{-79, 20}, {-61, 20}}, color = {0, 0, 127}));
  connect(solarIrradianceData.pvIrradiance, SolarFarm.solarIrradiance) annotation(
    Line(points = {{-79, -20}, {-61, -20}}, color = {0, 0, 127}));
  connect(energyStorage.canDischarge, powerManagementSystem.canDischarge) annotation(
    Line(points = {{-16, -49}, {-16, -35}, {-6, -35}, {-6, -23}}, color = {255, 0, 255}, pattern = LinePattern.Dash));
  connect(energyStorage.canCharge, powerManagementSystem.canCharge) annotation(
    Line(points = {{-12, -49}, {-12, -39}, {6, -39}, {6, -23}}, color = {255, 0, 255}, pattern = LinePattern.Dash));
  connect(energyStorage.StorageEnergyOut, kpi.StorageEnergy) annotation(
    Line(points = {{-24, -49}, {-24, 39}, {-6, 39}, {-6, 49}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(energyStorage.storageCapacityOut, kpi.StorageCapacity) annotation(
    Line(points = {{-28, -49}, {-28, 43}, {-8, 43}, {-8, 49}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableChargingStationDemandPowerOut, kpi.ChargingStationDemandPowerIn) annotation(
    Line(points = {{-16, 22}, {-16, 36}, {-4, 36}, {-4, 50}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableDomesticDemandPowerOut, kpi.domesticDemandPowerIn) annotation(
    Line(points = {{-10, 22}, {-10, 32}, {-2, 32}, {-2, 50}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableSolarGeneratedPowerOut, kpi.solarGeneratedPowerIn) annotation(
    Line(points = {{-4, 22}, {-4, 28}, {2, 28}, {2, 50}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableWindGeneratedPowerOut, kpi.windGeneratedPowerIn) annotation(
    Line(points = {{4, 22}, {4, 50}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.powerTransferedToStorageOut, kpi.storagePowerIn) annotation(
    Line(points = {{10, 22}, {10, 28}, {6, 28}, {6, 50}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.powerTransferedToGridOut, kpi.conventionalGridPowerIn) annotation(
    Line(points = {{16, 22}, {16, 32}, {8, 32}, {8, 50}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(windFarm.electricalPort, powerManagementSystem.windGenerationPort) annotation(
    Line(points = {{-39, 20}, {-33, 20}, {-33, 10}, {-23, 10}}));
  connect(SolarFarm.electricalPort, powerManagementSystem.solarGenerationPort) annotation(
    Line(points = {{-39, -20}, {-33, -20}, {-33, -10}, {-23, -10}}));
  connect(powerManagementSystem.chargingStationDemandPort, chargingStation.electricalPort) annotation(
    Line(points = {{22, 10}, {30, 10}, {30, 20}, {59, 20}}));
  connect(powerManagementSystem.domesticDemandPort, domesticConsumer.electricalPort) annotation(
    Line(points = {{22, -10}, {32, -10}, {32, -20}, {59, -20}}));
  connect(powerManagementSystem.sourceSinkPort, conventionalGrid.electricalPort) annotation(
    Line(points = {{14, -22}, {14, -30}, {20, -30}, {20, -48}}));
  connect(energyStorage.electricalPort, powerManagementSystem.storagePort) annotation(
    Line(points = {{-20, -49}, {-20, -31}, {-14, -31}, {-14, -23}}));
  annotation(
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 3600),
    Diagram(graphics = {Text(origin = {0, 90}, extent = {{100, -10}, {-100, 10}}, textString = "Group of Houses Grid Scenario (~200 Houses)", fontSize = 20)}, coordinateSystem(extent = {{-120, 100}, {100, -160}})),
  Documentation(info = "<html><head></head><body><!--StartFragment--><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\">Scenario 2:</span><div><font face=\"DejaVu Sans Mono\"><br></font><div><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\">This scenario is for around 200 house's electric demand and charging station (Simple data generated model).</span></div><div><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\"><br></span></div><div><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\">PV panels</span><span style=\"font-family: HiraKakuProN-W3, STXihei;\">&nbsp;at solar farm&nbsp;</span><span style=\"font-size: 12px; font-family: HiraKakuProN-W3, STXihei;\">and wind turbines at wind farm are the source for power, energy storage and conventional grid are also connected.</span><!--EndFragment--></div></div></body></html>"));
end Scenario2;
