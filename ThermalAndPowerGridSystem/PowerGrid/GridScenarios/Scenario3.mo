within ThermalAndPowerGridSystem.PowerGrid.GridScenarios;

model Scenario3
  extends Modelica.Icons.Example;
  ThermalAndPowerGridSystem.PowerGrid.Utilities.SystemParameters scenario3Parameters(domesticDemandData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/CityElectricityDemand.txt"), numberOfChargingStation = 200, numberOfTurbines = 600, numberofPvPanels = 200000, solarGenerationDataFile = "0", solarGenerationFactor = 0, storageCapacity = 900e6, storageSupplyPowerLimit = 50e6, windGeneratedPowerLimit = 350e6, windGenerationDataFile = "0", windGenerationFactor = 0)  annotation(
    Placement(visible = true, transformation(origin = {40, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Utilities.SolarIrradianceData solarIrradianceData(solarIrradianceData = scenario3Parameters.solarIrradianceData, pvTiltAngle = scenario3Parameters.pvTiltAngle)  annotation(
    Placement(visible = true, transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Utilities.WindPowerData windPowerData(airDensity = scenario3Parameters.airDensity, windSpeedData = scenario3Parameters.windSpeedData)  annotation(
    Placement(visible = true, transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.WindFarm windFarm(TurbineGenrationEfficiency = scenario3Parameters.TurbineGenrationEfficiency, numberOfTurbines = scenario3Parameters.numberOfTurbines, turbineRotorRadius = scenario3Parameters.turbineRotorRadius, windGeneratedPowerLimit = scenario3Parameters.windGeneratedPowerLimit)  annotation(
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.SolarFarm solarFarm(PvGenerationEfficiency = scenario3Parameters.PvGenerationEfficiency, numberofPvPanels = scenario3Parameters.numberofPvPanels, pvSurfaceArea = scenario3Parameters.pvSurfaceArea)  annotation(
    Placement(visible = true, transformation(origin = {-50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.PowerManagementSystem powerManagementSystem(V = scenario3Parameters.V, chargingStationCost = scenario3Parameters.chargingStationCost, dosmesticDemandCost = scenario3Parameters.dosmesticDemandCost, energyStorageCost = scenario3Parameters.energyStorageCost, solarGenCost = scenario3Parameters.solarGenCost, storageSupplyPowerLimit = scenario3Parameters.storageSupplyPowerLimit, tndEfficiency = scenario3Parameters.tndEfficiency, windGenCost = scenario3Parameters.windGenCost)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.Kpi kpi annotation(
    Placement(visible = true, transformation(origin = {0, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.EnergyStorage energyStorage(maxEnergyPercentage = scenario3Parameters.maxEnergyPercentage, minEnergyPercentage = scenario3Parameters.minEnergyPercentage, storageCapacity = scenario3Parameters.storageCapacity)  annotation(
    Placement(visible = true, transformation(origin = {-20, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.ConventionalGrid conventionalGrid annotation(
    Placement(visible = true, transformation(origin = {20, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.DomesticConsumer domesticConsumer(domesticDemandData = scenario3Parameters.domesticDemandData)  annotation(
    Placement(visible = true, transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.ChargingStation chargingStation(bikeChargingDuration = scenario3Parameters.bikeChargingDuration, carChargingDuration = scenario3Parameters.carChargingDuration, evBikeCapacity = scenario3Parameters.evBikeCapacity, evBikeChargingRating = scenario3Parameters.evBikeChargingRating, evCarCapacity = scenario3Parameters.evCarCapacity, evCarChargingRating = scenario3Parameters.evCarChargingRating, maxNumberOfBikePerChargingStation = scenario3Parameters.maxNumberOfBikePerChargingStation, maxNumberOfCarPerChargingStation = scenario3Parameters.maxNumberOfCarPerChargingStation, minNumberOfBikePerChargingStation = scenario3Parameters.minNumberOfBikePerChargingStation, minNumberOfCarPerChargingStation = scenario3Parameters.minNumberOfCarPerChargingStation, numberOfChargingStation = scenario3Parameters.numberOfChargingStation)  annotation(
    Placement(visible = true, transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(windPowerData.windOutputPower, windFarm.windPowerPerArea) annotation(
    Line(points = {{-78, 30}, {-60, 30}}, color = {0, 0, 127}));
  connect(solarIrradianceData.pvIrradiance, solarFarm.solarIrradiance) annotation(
    Line(points = {{-78, -30}, {-60, -30}}, color = {0, 0, 127}));
  connect(windFarm.electricalPort, powerManagementSystem.windGenerationPort) annotation(
    Line(points = {{-38, 30}, {-30, 30}, {-30, 10}, {-22, 10}}));
  connect(solarFarm.electricalPort, powerManagementSystem.solarGenerationPort) annotation(
    Line(points = {{-38, -30}, {-30, -30}, {-30, -10}, {-22, -10}}));
  connect(energyStorage.electricalPort, powerManagementSystem.storagePort) annotation(
    Line(points = {{-20, -58}, {-20, -34}, {-14, -34}, {-14, -22}}));
  connect(conventionalGrid.electricalPort, powerManagementSystem.sourceSinkPort) annotation(
    Line(points = {{20, -58}, {20, -34}, {14, -34}, {14, -22}}));
  connect(energyStorage.canDischarge, powerManagementSystem.canDischarge) annotation(
    Line(points = {{-16, -58}, {-16, -40}, {-6, -40}, {-6, -22}}, color = {255, 0, 255}, pattern = LinePattern.Dash));
  connect(energyStorage.canCharge, powerManagementSystem.canCharge) annotation(
    Line(points = {{-12, -58}, {-12, -46}, {6, -46}, {6, -22}}, color = {255, 0, 255}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.domesticDemandPort, domesticConsumer.electricalPort) annotation(
    Line(points = {{22, -10}, {40, -10}, {40, -30}, {60, -30}}));
  connect(powerManagementSystem.chargingStationDemandPort, chargingStation.electricalPort) annotation(
    Line(points = {{22, 10}, {40, 10}, {40, 30}, {60, 30}}));
  connect(energyStorage.storageCapacityOut, kpi.StorageCapacity) annotation(
    Line(points = {{-28, -58}, {-28, 36}, {-8, 36}, {-8, 40}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(energyStorage.StorageEnergyOut, kpi.StorageEnergy) annotation(
    Line(points = {{-24, -58}, {-26, -58}, {-26, 34}, {-6, 34}, {-6, 40}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableChargingStationDemandPowerOut, kpi.ChargingStationDemandPowerIn) annotation(
    Line(points = {{-16, 22}, {-16, 32}, {-4, 32}, {-4, 40}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableDomesticDemandPowerOut, kpi.domesticDemandPowerIn) annotation(
    Line(points = {{-10, 22}, {-10, 30}, {-2, 30}, {-2, 40}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableSolarGeneratedPowerOut, kpi.solarGeneratedPowerIn) annotation(
    Line(points = {{-4, 22}, {-4, 28}, {2, 28}, {2, 40}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableWindGeneratedPowerOut, kpi.windGeneratedPowerIn) annotation(
    Line(points = {{4, 22}, {4, 40}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.powerTransferedToStorageOut, kpi.storagePowerIn) annotation(
    Line(points = {{10, 22}, {10, 28}, {6, 28}, {6, 40}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.powerTransferedToGridOut, kpi.conventionalGridPowerIn) annotation(
    Line(points = {{16, 22}, {16, 30}, {8, 30}, {8, 40}}, color = {0, 0, 127}, pattern = LinePattern.Dash));

annotation(
    Diagram(graphics = {Text(origin = {0, 90}, extent = {{100, -10}, {-100, 10}}, textString = "City Grid Scenario (~75,000 Houses)", fontSize = 20)}),
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-6, Interval = 3600),
  Documentation(info = "<html><head></head><body><div><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\">Scenario 3:</span></div><div><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\"><br></span></div><div><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\">This scenario is for around 75000 house's electric demand and charging station (Simple data generated model).</span></div><div><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\"><br></span></div><div><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\">PV panels</span><span style=\"font-family: HiraKakuProN-W3, STXihei;\">&nbsp;at solar farm&nbsp;</span><span style=\"font-size: 12px; font-family: HiraKakuProN-W3, STXihei;\">and wind turbines at wind farm are the source for power, energy storage and conventional grid are also connected.</span></div></body></html>"));
end Scenario3;
