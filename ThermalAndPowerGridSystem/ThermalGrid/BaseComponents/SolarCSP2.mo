within ThermalAndPowerGridSystem.ThermalGrid.BaseComponents;

model SolarCSP2 "Given hourly irradiation data and parameters, output energy of solar CSP is modeled for annual simulation"
  extends Icons.CSP;
  extends SystemSetup.SystemFluid;
  import HTC = Modelica.Units.SI.CoefficientOfHeatTransfer;
  import Modelica.Units.SI.Power;
  import Modelica.Units.SI.Area;
  import Modelica.Units.SI.Temperature;
  import Modelica.Units.SI.Angle;
  import Modelica.Units.SI.AbsolutePressure;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  import Modelica.Units.SI.MassFlowRate;
  import Modelica.Units.SI.SpecificEnthalpy;
  import Modelica.Units.SI.Efficiency;
  import Modelica.Units.SI.PerUnit;
  import Modelica.Units.SI.Energy;
  
  Area area = 5.5 " Collector Aperture area";
  Area totalArea;
 
  //Parameters of Absolicon T160 Solar Collector
  parameter HTC h1 = 0.368 "Heat Loss coefficient of collector at ambient temperature (W/m2.K)";
  //Performance Parameters based on aperature area
  parameter Real h2 = 0.00322 "Temperature dependence of Heat Loss coefficient of collector (W/m2K2)";
  parameter Efficiency collectorEfficiency = 0.766 "Collector Efficiency";
  parameter Real AngleDiffuse = 0.0859 "Incident angle modifier for diffuse solar radiation";
  parameter Temperature Tamb = 300 "Ambient Temperature (K)";
  parameter Temperature Tmed = 450 "Collector fluid medium temperature (K)";
  parameter AbsolutePressure operatingP = 2e5 " Operating pressure of the solar collector";
  parameter Real SolarCapacity = 100 "Capacity of Solar field utilized in percentage";
  Modelica.Blocks.Interfaces.RealInput directIrradiation "Measured direct solar irradiation profile" annotation(
              Placement(visible = true, transformation(origin = {-113, 1}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {-118, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.ThermalPort heatOutput annotation(
    Placement(visible = true, transformation(origin = {-22, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  AbsoluteTemperature outputTemperature "dummy value";
  Power qInstantaneous "Instantaneous Heat Production (W/m2)";
  Power Qloss;
  Power Q "Useful output energy";


  parameter  PerUnit NumberOfCollectors = 200;

equation
 
   if qInstantaneous > 0 then //Energy Loss
    Qloss = h1 * (Tmed - Tamb) + h2 * (Tmed - Tamb) ^ 2;
  else
    Qloss = 0;
  end if;
  
  qInstantaneous = collectorEfficiency*directIrradiation;
  Q = qInstantaneous * totalArea "Useful Energy";/*-(Qloss*area)*/
  totalArea = NumberOfCollectors*area*(SolarCapacity*0.01);
  outputTemperature = FluidWater.temperature_phX(operatingP, Q, {1});
   -Q = heatOutput.W;
  outputTemperature = heatOutput.T; 

 annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    Documentation(info = "<html><head></head><body>Hourly Direct Irradiation data is taken from the <b>Solar Irradiation Data</b> model to give the output power of the Solar CSP.</body></html>"));
end SolarCSP2;
