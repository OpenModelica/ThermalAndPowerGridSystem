within ThermalAndPowerGridSystem.ThermalGrid.CompoundComponents.Storage;

model Pit2 "Stratified Tank...Geometry: Conical Frustrum" 
  
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
  import Modelica.Units.SI.Volume;
  import Modelica.Units.SI.Angle;  
  
  parameter Radius radiusTop = 50.7 "Top radius of Tank";
  parameter Radius radiusBottom = 14.6 "Bottom radius of Tank";
  parameter Height heightTank = 16 "Tank height";
  parameter Angle slopeTank = 23.9*pi/180;
  parameter Integer node = 10 "Number of nodes that the TES is assumed to be divided into";
  parameter Real SingleDer[node, node] = ThermalAndPowerGridSystem.ThermalGrid.Functions.FDFESingleDer(N = node, z = points, L = heightTank);
  parameter Real DoubleDer[node, node] = ThermalAndPowerGridSystem.ThermalGrid.Functions.FDFEDoubleDer(N = node, z = points, L = heightTank);
  parameter Real points[node] = linspace(0, heightTank, node);
  parameter VolumeFlowRate Vw =1000"Volume Flowrate of medium";
  parameter PerUnit Uside = 1 "Heat transfer coefficient";
 
  PerUnit pi = Modelica.Constants.pi;
  Density density "Density of medium";
  SpecificHeatCapacity cp "Specific Heat Capacity of medium";
  ThermalConductivity thermalConductivity "Thermal Conductivity of medium";
  
  Area areaOfNode[node] "Cross-sectional area of a segment";
  Area areaTop, areaBottom " Cross-sectional area of first and last segment respectively";
  Height slantHeightTank "Slant Height of the tank";
  Height perimeter[node] "Perimeter of a segment";
  Energy Qloss[node] " Energy loss in each segment";
  AbsoluteTemperature Tnode[node, 1], Tvariation[node], Tground = 298;
  Volume volumeTank"Frustrum total volume";
  Volume volumeNode = volumeTank /node  "Volume of each segment";
  Height heightNode[node], radiusNode[node + 1] "Height and bottom radius of each segment" ;
  Length slantHeight[node]  "Slant height of each segment";
  //Tground[node];
  //Boolean charging "=1 if charging =0 if discharging";

initial equation
  for a in 1:node loop
    if a == 1 then
      Tnode[a, 1] = 373.0;
    elseif a == node then
      Tnode[a, 1] = 343;
    else
      Tnode[a, 1] - (273 + 95) = -30 / heightTank * points[a];
    end if;
  end for;
  
 equation
   volumeTank = pi/ 3 * (radiusBottom^ 2 + radiusBottom* radiusTop + radiusTop ^ 2) * heightTank;
    radiusNode[node] = radiusBottom;
    
    for i in 1:node-1  loop
        if i==1 then
         volumeNode = (pi / 3) * (radiusTop ^ 2 + radiusTop * radiusNode[i] + radiusNode[i] ^ 2) * heightNode[i];
         volumeTank - volumeNode = pi / 3 * (radiusNode[i] ^ 2 + radiusBottom * radiusNode[i] + radiusBottom ^ 2) * (heightTank - heightNode[i]);
      else  
        volumeNode = pi/ 3 * (radiusNode[i] ^ 2 + radiusNode[i] * radiusNode[i - 1] + radiusNode[i - 1] ^ 2) * heightNode[i];
        volumeTank - i * volumeNode = pi / 3 * (radiusNode[i ] ^ 2 + radiusNode[i ] * radiusBottom + radiusBottom ^ 2) * (heightTank - sum(heightNode[1:i]));
      end if;
      slantHeight[i] = sqrt(heightNode[i]^2 + (radiusNode[i+1] - radiusNode[i])^2);
   end for;
 heightNode[node] = heightTank-sum(heightNode[1:node-1]);
 // slantHeight[node] = sqrt(heightNode[i]^2 + (radiusNode[node-1] - radiusNode[i])^2);
   density = 1000;
  cp = 4200;
  thermalConductivity = 0.6;
  
  areaTop = pi*radiusTop^2;
  areaBottom = areaOfNode[node];
  slantHeightTank = heightNode*sin(slopeTank);
    for i in 1:node loop
    areaOfNode[i] = pi*radiusNode[i]^2;
    perimeter[i] = radiusNode * 2 * pi * heightNode[i];
    if i == 1 then
      Qloss[i] = areaTop * Uside * (Tnode[i, 1] - Tground);
    elseif i == node then
      Qloss[i] = areaBottom * Uside * (Tnode[i, 1] - Tground);
    else
      Qloss[i] = Uside * perimeter[i] * (Tnode[i, 1] - Tground);
    end if;
  end for;
  
  for i in 1:node loop
    density * areaOfNode[i] * cp * der(Tnode[i, 1]) = (-density * Vw * cp * (SingleDer[i, :] * Tnode[:, 1])) + areaOfNode[i] * thermalConductivity * (DoubleDer[i, :] * Tnode[:, 1]) - Qloss[i];
  end for;
  Tvariation[:] = Tnode[:, 1];
  
   annotation(
    experiment(StartTime = 0, StopTime = 500, Tolerance = 1e-06, Interval = 1));
end Pit2;
