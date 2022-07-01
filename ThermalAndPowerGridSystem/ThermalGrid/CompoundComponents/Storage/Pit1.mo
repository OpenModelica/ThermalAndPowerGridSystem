within ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.Storage;

model Pit1 "Stratified Tank...Geometry: Pyramid Stump"
   extends ThermalAndPowerGridSystem.ThermalGrid.Icons.PitTES;
   extends ThermalAndPowerGridSystem.ThermalGrid.SystemSetup.SystemFluid;
   SystemSetup.Constants constants;
   /*outer*/ SystemSetup.AmbientConditions ambientConditions;
  
  import Modelica.Units.SI.PerUnit;
  import Modelica.Units.SI.Density;
  import Modelica.Units.SI.SpecificHeatCapacity;
  import Modelica.Units.SI.ThermalConductivity;
  import Modelica.Units.SI.VolumeFlowRate;
  import Modelica.Units.SI.Area;
  import Modelica.Units.SI.Energy;
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  import Modelica.Units.SI.Height;
  import Modelica.Units.SI.Radius;
  import Modelica.Units.SI.Length;
  import Modelica.Units.SI.Pressure;
  
  parameter Pressure PTop = ambientConditions.PAtm;
  parameter Integer node = 10 "Number of nodes that the TES is divided into";
  parameter Height heightTank = 1000;
  parameter Length topLengthTank =40;
  parameter Length bottomLengthTank = 20;
  parameter Real SingleDer[node, node] = ThermalAndPowerGridSystem.ThermalGrid.Functions.FDFESingleDer(N = node, z = points, L = heightTank);
  parameter Real DoubleDer[node, node] = ThermalAndPowerGridSystem.ThermalGrid.Functions.FDFEDoubleDer(N = node, z = points, L = heightTank);
  parameter Real points[node] = linspace(0, heightTank, node);
   parameter AbsoluteTemperature inletTemperature = 363,outletTemperature=333;
   
    
  PerUnit pi = Modelica.Constants.pi;
  Density liquidDensity "Density of medium";
  SpecificHeatCapacity cp "Specific Heat Capacity of medium";
  ThermalConductivity thermalConductivity "Thermal Conductivity of medium";
  parameter VolumeFlowRate Vw =100 "Volume Flowrate of medium";
  Area areaOfNode[node] "Cross-sectional area of a segment";
  Area areaTop, areaBottom " Cross-sectional area of first and last segment respectively";
  Height perimeter[node] "Perimeter of a segment";
  Height heightNode[node] " Height of each segment";
  Length lengthNode[node] "Length of each segment";
  Energy Qloss[node];
  AbsoluteTemperature Tnode[node, 1], Tvariation[node], Tground = 298;
  //Tground[node];
  parameter PerUnit Uside = 1 "Heat transfer coefficient";
  //Boolean charging "=1 if charging =0 if discharging";

  
  

initial equation
  for a in 1:node loop
//    if a == 1 then
//      Tnode[a, 1] = inletTemperature;
//    elseif a == node then
//      Tnode[a, 1] = outletTemperature;
//    else
      Tnode[a, 1] - inletTemperature = (outletTemperature - inletTemperature) / heightTank * points[a];
//    end if;
  end for;
  
equation
 liquidDensity = 1000;
  cp = 4200;
  thermalConductivity = 0.6;
  
  areaTop = areaOfNode[1];
  areaBottom = areaOfNode[node];
  
  for i in 1:node loop
    /*perimeter[i] = 2*( topLengthTank + bottomLengthTank)*sqrt(heightNode[i]^2 +((topLengthTank-bottomLengthTank)/2)^2)*/ /*2* heightNode[i]*(lengthTank+breadthTank);*/
   if i==1 then
    perimeter[i] = 2*( topLengthTank + lengthNode[i])*sqrt(heightNode[i]^2 +((topLengthTank-bottomLengthTank)/2)^2);
    else
    perimeter[i] = 2*( lengthNode[i] + lengthNode[i-1])*sqrt(heightNode[i]^2 +((topLengthTank-bottomLengthTank)/2)^2);
    end if;
    if i == 1 then
      Qloss[i] = areaTop * Uside * (Tnode[i, 1] - Tground);
    elseif i == node then
      Qloss[i] = areaBottom * Uside * (Tnode[i, 1] - Tground);
    else
      Qloss[i] = Uside * perimeter[i] * (Tnode[i, 1] - Tground);
    end if;
  end for;
  
  heightNode = fill(heightTank / node, node);
  areaOfNode = fill(lengthTank*breadthTank, node);
  

//  liquidDensity = FluidWater.density_phX(inletPort.pressure, inletPort.specificEnthalpyTank, {1});


  for i in 1:node loop
    liquidDensity * areaOfNode[i] * cp * der(Tnode[i, 1]) = (-liquidDensity * Vw * cp * (SingleDer[i, :] * Tnode[:, 1])) + areaOfNode[i] * thermalConductivity * (DoubleDer[i, :] * Tnode[:, 1]) - Qloss[i];
  end for;
  
  Tvariation[:] = Tnode[:, 1];
  annotation(
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 2));
end Pit1;
