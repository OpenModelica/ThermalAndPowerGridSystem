within ThermalAndPowerGridSystem.PowerGrid.GridScenarios;

model Scenario1
  extends Modelica.Icons.Example;
  ThermalAndPowerGridSystem.PowerGrid.Utilities.SystemParameters Scenario1Parameter( PvGenerationEfficiency = 0.2,TurbineGenrationEfficiency = 0, V = 415, bikeChargingDuration = 0, carChargingDuration = 0, chargingStationCost = 0, domesticDemandData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/SingleHouseElectricityDemand.txt"), evBikeCapacity = 0, evBikeChargingRating = 0, evCarCapacity = 0, evCarChargingRating = 0, maxNumberOfBikePerChargingStation = 0, maxNumberOfCarPerChargingStation = 0, minNumberOfBikePerChargingStation = 0, minNumberOfCarPerChargingStation = 0, numberOfChargingStation = 0, numberOfTurbines = 0, numberofPvPanels = 12, pvSurfaceArea = 2, solarGenerationDataFile = "0", storageCapacity = 5e3, storageSupplyPowerLimit = 1e3, turbineRotorRadius = 0, windGenCost = 0, windGeneratedPowerLimit = 0, windGenerationDataFile = "0", windSpeedData = "0") annotation(
    Placement(visible = true, transformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Utilities.SolarIrradianceData solarIrradianceData(solarIrradianceData = Scenario1Parameter.solarIrradianceData ,pvTiltAngle = Scenario1Parameter.pvTiltAngle)  annotation(
    Placement(visible = true, transformation(origin = {-90, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.SolarFarm pvPanels(PvGenerationEfficiency = Scenario1Parameter.PvGenerationEfficiency, numberofPvPanels = Scenario1Parameter.numberofPvPanels, pvSurfaceArea = Scenario1Parameter.pvSurfaceArea) annotation(
    Placement(visible = true, transformation(origin = {-50, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.PowerManagementSystem powerManagementSystem(V = Scenario1Parameter.V, chargingStationCost = Scenario1Parameter.chargingStationCost, dosmesticDemandCost = Scenario1Parameter.dosmesticDemandCost, energyStorageCost = Scenario1Parameter.energyStorageCost, solarGenCost = Scenario1Parameter.solarGenCost, storageSupplyPowerLimit = Scenario1Parameter.storageSupplyPowerLimit, tndEfficiency = Scenario1Parameter.tndEfficiency, windGenCost = Scenario1Parameter.windGenCost)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.EnergyStorage energyStorage(maxEnergyPercentage = Scenario1Parameter.maxEnergyPercentage, minEnergyPercentage = Scenario1Parameter.minEnergyPercentage, storageCapacity = Scenario1Parameter.storageCapacity)  annotation(
    Placement(visible = true, transformation(origin = {-20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.ConventionalGrid conventionalGrid annotation(
    Placement(visible = true, transformation(origin = {20, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.DomesticConsumer domesticConsumer(domesticDemandData = Scenario1Parameter.domesticDemandData)  annotation(
    Placement(visible = true, transformation(origin = {70, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Components.Kpi kpi annotation(
    Placement(visible = true, transformation(origin = {0, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(solarIrradianceData.pvIrradiance, pvPanels.solarIrradiance) annotation(
    Line(points = {{-79, -10}, {-61, -10}}, color = {0, 0, 127}));
  connect(energyStorage.storageCapacityOut, kpi.StorageCapacity) annotation(
    Line(points = {{-28, -49}, {-28, 35}, {-8, 35}, {-8, 41}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(energyStorage.StorageEnergyOut, kpi.StorageEnergy) annotation(
    Line(points = {{-24, -49}, {-26, -49}, {-26, 33}, {-6, 33}, {-6, 41}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableChargingStationDemandPowerOut, kpi.ChargingStationDemandPowerIn) annotation(
    Line(points = {{-16, 22}, {-16, 32}, {-4, 32}, {-4, 42}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableDomesticDemandPowerOut, kpi.domesticDemandPowerIn) annotation(
    Line(points = {{-10, 22}, {-10, 30}, {-2, 30}, {-2, 42}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableSolarGeneratedPowerOut, kpi.solarGeneratedPowerIn) annotation(
    Line(points = {{-4, 22}, {-4, 28}, {2, 28}, {2, 42}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.availableWindGeneratedPowerOut, kpi.windGeneratedPowerIn) annotation(
    Line(points = {{4, 22}, {4, 42}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.powerTransferedToStorageOut, kpi.storagePowerIn) annotation(
    Line(points = {{10, 22}, {10, 28}, {6, 28}, {6, 42}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(powerManagementSystem.powerTransferedToGridOut, kpi.conventionalGridPowerIn) annotation(
    Line(points = {{16, 22}, {16, 30}, {8, 30}, {8, 42}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(pvPanels.electricalPort, powerManagementSystem.solarGenerationPort) annotation(
    Line(points = {{-39, -10}, {-23, -10}}));
  connect(powerManagementSystem.domesticDemandPort, domesticConsumer.electricalPort) annotation(
    Line(points = {{22, -10}, {59, -10}}));
  connect(energyStorage.electricalPort, powerManagementSystem.storagePort) annotation(
    Line(points = {{-20, -49}, {-20, -35}, {-14, -35}, {-14, -23}}));
  connect(conventionalGrid.electricalPort, powerManagementSystem.sourceSinkPort) annotation(
    Line(points = {{20, -49}, {20, -37}, {14, -37}, {14, -23}}));
  connect(energyStorage.canDischarge, powerManagementSystem.canDischarge) annotation(
    Line(points = {{-16, -49}, {-16, -37}, {-6, -37}, {-6, -23}}, color = {255, 0, 255}, pattern = LinePattern.Dash));
  connect(energyStorage.canCharge, powerManagementSystem.canCharge) annotation(
    Line(points = {{-12, -49}, {-12, -39}, {6, -39}, {6, -23}}, color = {255, 0, 255}, pattern = LinePattern.Dash));
  annotation(
    experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-06, Interval = 3600),
    Diagram(graphics = {Text(origin = {0, 90}, extent = {{100, -10}, {-100, 10}}, textString = "Single House Grid Scenario", fontSize = 20)}),
  Documentation(info = "<html><head></head><body><!--StartFragment-->Scenario 1:<div><br><div>This scenario is for single house demand.</div><div><br></div><div>Set of PV panels on roof of the house as source of power, energy storage and conventional grid&nbsp;<span style=\"font-family: HiraKakuProN-W3, STXihei; font-size: 12px;\">&nbsp;</span><span style=\"font-family: HiraKakuProN-W3, STXihei; font-size: 12px;\">are also connected</span>&nbsp;.</div></div></body></html>"));
end Scenario1;
