within ThermalAndPowerGridSystem.ThermalGrid.BaseComponents;

model SolarCSP "Given monthly irradiation data and parameters, output energy of solar CSP( Concetrated Solar Power) is modeled for annual simulation"
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
  
  parameter Area area = 5.5 " Collector Aperture area";
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
         
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.ThermalPort heatOutput annotation(
    Placement(visible = true, transformation(origin = {-22, -92}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, -110}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  AbsoluteTemperature outputTemperature "dummy value";
  Power qInstantaneous "Instantaneous Heat Production (W/m2)";
  Power Qloss;
  Power Q "Useful output energy";
  
  
  Real AngleBeam " Incident angle modifier for beam solar radiation";
  Real incidentAngle;
  
  parameter Energy[12] MonthlyGlobalIrradiationData = {11.05e3, 46.32e3, 97.55e3, 130.78e3, 174.46e3, 149.8e3, 155.91e3, 125.25e3, 92.75e3, 55.37e3, 10.47e3, 2.3e3};
  parameter PerUnit[12] diffuseToGlobalRatio = {0.79, 0.58, 0.55, 0.51, 0.42, 0.43, 0.44, 0.47, 0.45, 0.53, 0.84, 0.91};
  parameter PerUnit[12] daysOfMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  parameter PerUnit[12] cumDays = {31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365};
  parameter PerUnit[12]NumberOfCollectors = {20,18,10,4,4,4,4,20,20,20,20,18};
  parameter Integer id = Modelica.Math.Random.Utilities.initializeImpureRandom(globalSeed) "A unique number used to sort equations correctly";
  parameter Integer globalSeed = 300 "Global seed to initialize random number generator";
  parameter Modelica.Units.SI.Period samplePeriod = 3600 "Sample period for the generation of random numbers";
  discrete Real rImpure "Impure Real random number";
  PerUnit noise;
  Power opPower;
  PerUnit diffuseRatio;
  Real[12] x, xHeight;
  Real y, days, hour, xHt, diffuse, beam;
  
algorithm
  AngleBeam := ThermalAndPowerGridSystem.ThermalGrid.Functions.AngleModifierBeamCalculator(incidentAngle);
algorithm
  when initial() then
    rImpure := 0;
  elsewhen sample(0, samplePeriod) then
    rImpure := Modelica.Math.Random.Utilities.impureRandom(id = id);
  end when;
equation
   incidentAngle = 45;
  for i in 1:12 loop
    x[i] = 2 * MonthlyGlobalIrradiationData[i] / daysOfMonth[i];
    xHeight[i] = 3 / 24 * x[i];

  end for;
  hour = mod(div(time, 3600), 24);
  days = div(time, 3600 * 24);
  if days < cumDays[1] - 1e-8 then
      xHt = xHeight[1];
      diffuseRatio = diffuseToGlobalRatio[1];
      totalArea = NumberOfCollectors[1]*area;
  elseif days < cumDays[2] - 1e-8 then
      xHt = xHeight[2];
      diffuseRatio = diffuseToGlobalRatio[2];
      totalArea = NumberOfCollectors[2]*area;
  elseif days < cumDays[3] - 1e-8 then
      xHt = xHeight[3];
      diffuseRatio = diffuseToGlobalRatio[3];
      totalArea = NumberOfCollectors[3]*area;
  elseif days < cumDays[4] - 1e-8 then
      xHt = xHeight[4];
      diffuseRatio = diffuseToGlobalRatio[4];
      totalArea = NumberOfCollectors[4]*area;
  elseif days < cumDays[5] - 1e-8 then
      xHt = xHeight[5];
      diffuseRatio = diffuseToGlobalRatio[5];
      totalArea = NumberOfCollectors[5]*area;
  elseif days < cumDays[6] - 1e-8 then
      xHt = xHeight[6];
      diffuseRatio = diffuseToGlobalRatio[6];
      totalArea = NumberOfCollectors[6]*area;
  elseif days < cumDays[7] - 1e-8 then
      xHt = xHeight[7];
      diffuseRatio = diffuseToGlobalRatio[7];
      totalArea = NumberOfCollectors[7]*area;
 elseif days < cumDays[8] - 1e-8 then
      xHt = xHeight[8];
      diffuseRatio = diffuseToGlobalRatio[8];
      totalArea = NumberOfCollectors[8]*area;
 elseif days < cumDays[9] - 1e-8 then
      xHt = xHeight[9];
      diffuseRatio = diffuseToGlobalRatio[9];
      totalArea = NumberOfCollectors[9]*area;
 elseif days < cumDays[10] - 1e-8 then
      xHt = xHeight[10];
      diffuseRatio = diffuseToGlobalRatio[10];
      totalArea = NumberOfCollectors[10]*area;
 elseif days < cumDays[11] - 1e-8 then
      xHt = xHeight[11];
      diffuseRatio = diffuseToGlobalRatio[11];
      totalArea = NumberOfCollectors[11]*area;
 elseif days < cumDays[12] - 1e-8 then
      xHt = xHeight[12];
      diffuseRatio = diffuseToGlobalRatio[12];
      totalArea = NumberOfCollectors[12]*area;
else
      xHt = 0;
      diffuseRatio = 0;
      totalArea = NumberOfCollectors[12]*area;
end if;
 
  noise = xHt * rImpure * 0.1;
  y = xHt * ((-hour ^ 2 / 36) + 2 / 3 * hour - 3);
  
  if y < 0 then
    opPower = 0; 
  else
    opPower = y * noise "Output Power of Solar Collector";
  end if;
  opPower * diffuseRatio = diffuse;
  opPower * (1 - diffuseRatio) = beam;

if qInstantaneous > 0 then
    Qloss = h1 * (Tmed - Tamb) + h2 * (Tmed - Tamb) ^ 2;
  else
    Qloss = 0;
  end if;
  
  qInstantaneous = collectorEfficiency * AngleDiffuse * diffuse + collectorEfficiency * AngleBeam * beam;
  Q = qInstantaneous * totalArea "Useful Energy"; /*-(Qloss*area)*/
  outputTemperature = FluidWater.temperature_phX(operatingP, Q, {1});
  
  -Q = heatOutput.W;
  outputTemperature = heatOutput.T;
  
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
    Documentation(info = "<html><head></head><body>Monthly average Global Irradiation data is input to this model which is processed to a predefined profile of hourly data. This data is then utilizaed to calculate the output power of the Solar CSP.</body></html>"));
end SolarCSP;
