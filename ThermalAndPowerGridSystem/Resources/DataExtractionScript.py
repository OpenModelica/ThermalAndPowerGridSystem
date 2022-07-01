from matplotlib.pyplot import close
import pandas as pd
import os

MeteorologicalData_UnwantedRows = 18   # Meteorological Data Norrkoping - No. of text rows in the file (To be removed)
MeteorologicalData_Year = 2007 # Meteorological Data Norrkoping- Enter the year of data to be extracted

WeatherData_File = "DataSources/WeatherDataSource-5.csv" # Original Data File - Select appropriate file based on the required location
WeatherData_Location = 'NL' # Open Power System Data - Enter the initials of the location 
WeatherData_Year = '2013' # Open Power System Data - Enter the year of data to be extracted

ElectricalData_File = "DataSources/ElectricalGenerationLoadDataSource-2.csv" # Original Data File - Select appropriate file based on the required location
ElectricalData_Location = 'NL' # Open Power System Data - Enter the initials of the location
ElectricalData_Year = '2016' # Open Power System Data - Enter the year of data to be extracted

HeatDemandData_File = "DataSources/HeatDemandDataSource-3.csv" # Original Data File - Select appropriate file based on the required location
HeatDemandData_Location = 'NL' # Open Power System Data - Enter the initials of the location
HeatDemandData_Year = '2013' # Open Power System Data - Enter the year of data to be extracted

# Meteorological data extraction of solar irradiance (Global & Direct) for PV and CSP models

with open("DataSources/MeteorologicalDataSource.txt", encoding= 'unicode_escape') as f:
    mylist = f.read().splitlines()
newlist = mylist[:MeteorologicalData_UnwantedRows]
thefile = open('data.txt', 'w')
del mylist[:MeteorologicalData_UnwantedRows]
for item in mylist:
  thefile.write("%s\n" % item)

widths = [4, 3, 3, 3, 8, 8, 7, 2 ,7 ,2 ,7 ,2 ,7 ,2 ,7 ,2 ,7 ,2]
df = pd.read_fwf("data.txt", widths=widths, header=None)
df = df[df[0] == MeteorologicalData_Year]
df.reset_index(drop=True, inplace=True)
global_radiance= df.iloc[:, 10]
data = f'#1\ndouble pvSolarIrradiance(8760,2)\n'
for i in range(0,8760) :
    data = data + str(i) +'  '+ str(global_radiance[i])+ '\n'
direct_radiance= df.iloc[:, 6]
data = data + f'\n#1\ndouble cspSolarIrradiance(8760,2)\n'
for i in range(0,8760) :
    data = data + str(i) +'  '+ str(direct_radiance[i])+ '\n'
with open('CombiTableFiles/SolarIrradiance.txt','w') as h:
    h.write(data+'\n')
thefile.close()
os.remove('data.txt')

# Open power system data extraction of direct solar irradiance for thermal models

IrradianceColumnName = WeatherData_Location + '_radiation_direct_horizontal'
IrradianceData = pd.read_csv(WeatherData_File,usecols=["utc_timestamp", IrradianceColumnName])
IrradianceYearFilter = IrradianceData.utc_timestamp.str.contains(WeatherData_Year)
IrradianceData = IrradianceData[IrradianceYearFilter]
IrradianceData.reset_index(drop=True, inplace=True)
IrradianceData['utc_timestamp'] = range(0, len(IrradianceData))
IrradianceTableHeadder = "#1\ndouble cspSolarIrradiance(8760,2)\n"
with open('CombiTableFiles/DirectSolarIrradiance.txt','w') as fileObject1:
    fileObject1.write(IrradianceTableHeadder)
IrradianceData.to_csv('CombiTableFiles/DirectSolarIrradiance.txt', header=None, index=None, sep='\t', mode='a+')

# Open power system data extraction of air temperature for thermal models

TemperatureColumnName = WeatherData_Location + '_temperature'
TemperatureData = pd.read_csv(WeatherData_File,usecols=["utc_timestamp", TemperatureColumnName])
TemperatureYearFilter = TemperatureData.utc_timestamp.str.contains(WeatherData_Year)
TemperatureData = TemperatureData[TemperatureYearFilter]
TemperatureData.reset_index(drop=True, inplace=True)
TemperatureData['utc_timestamp'] = range(0, len(TemperatureData))
TemperatureTableHeadder = "#1\ndouble airTemperature(8760,2)\n"
with open('CombiTableFiles/AirTemperature.txt','w') as fileObject2:
    fileObject2.write(TemperatureTableHeadder)
TemperatureData.to_csv('CombiTableFiles/AirTemperature.txt', header=None, index=None, sep='\t', mode='a+')

# Open power system data extraction of space heat demand for thermal models

HeatLoadColumnName = HeatDemandData_Location + '_heat_demand_space'
HeatDemandData = pd.read_csv(HeatDemandData_File,usecols=["utc_timestamp", HeatLoadColumnName])
HeatDemandYearFilter = HeatDemandData.utc_timestamp.str.contains(HeatDemandData_Year)
HeatDemandData = HeatDemandData[HeatDemandYearFilter]
HeatDemandData.reset_index(drop=True, inplace=True)
HeatDemandData['utc_timestamp'] = range(0, len(HeatDemandData))
HeatDemandTableHeadder = "#1\ndouble heatDemand(8760,2)\n"
with open('CombiTableFiles/CountryHeatDemand.txt','w') as fileObject6:
    fileObject6.write(HeatDemandTableHeadder)
HeatDemandData.to_csv('CombiTableFiles/CountryHeatDemand.txt', header=None, index=None, sep='\t', mode='a+')

# Open power system data extraction of electrical demand for electrical models

ElectricalLoadColumnName = ElectricalData_Location + '_load_actual_entsoe_transparency'
ElectricalLoadData = pd.read_csv(ElectricalData_File,usecols=["utc_timestamp", ElectricalLoadColumnName])
ElectricalYearFilter = ElectricalLoadData.utc_timestamp.str.contains(ElectricalData_Year)
ElectricalLoadData = ElectricalLoadData[ElectricalYearFilter]
ElectricalLoadData.reset_index(drop=True, inplace=True)
ElectricalLoadData['utc_timestamp'] = range(0, len(ElectricalLoadData))
ElectricalLoadData[ElectricalLoadColumnName] = ElectricalLoadData[ElectricalLoadColumnName] * 1000
ElectricalLoadTableHeadder = "#1\ndouble domesticDemand(8784,2)\n"
with open('CombiTableFiles/CountryElectricityDemand.txt','w') as fileObject3:
    fileObject3.write(ElectricalLoadTableHeadder)
ElectricalLoadData.to_csv('CombiTableFiles/CountryElectricityDemand.txt', header=None, index=None, sep='\t', mode='a+')

# Open power system data extraction of solar generation for electrical models

ElectricalSolarColumnName = ElectricalData_Location + '_solar_generation_actual'
ElectricalSolarData = pd.read_csv(ElectricalData_File,usecols=["utc_timestamp", ElectricalSolarColumnName])
ElectricalYearFilter = ElectricalSolarData.utc_timestamp.str.contains(ElectricalData_Year)
ElectricalSolarData = ElectricalSolarData[ElectricalYearFilter]
ElectricalSolarData.reset_index(drop=True, inplace=True)
ElectricalSolarData['utc_timestamp'] = range(0, len(ElectricalSolarData))
ElectricalSolarData.fillna(0,inplace = True)
ElectricalSolarTableHeadder = "#1\ndouble solarGeneration(8784,2)\n"
with open('CombiTableFiles/CountrySolarGeneration.txt','w') as fileObject4:
    fileObject4.write(ElectricalSolarTableHeadder)
ElectricalSolarData.to_csv('CombiTableFiles/CountrySolarGeneration.txt', header=None, index=None, sep='\t', mode='a+')

# Open power system data extraction of wind generation for electrical models

ElectricalWindColumnName = ElectricalData_Location + '_wind_generation_actual'
ElectricalWindData = pd.read_csv(ElectricalData_File,usecols=["utc_timestamp", ElectricalWindColumnName])
ElectricalYearFilter = ElectricalWindData.utc_timestamp.str.contains(ElectricalData_Year)
ElectricalWindData = ElectricalWindData[ElectricalYearFilter]
ElectricalWindData.reset_index(drop=True, inplace=True)
ElectricalWindData['utc_timestamp'] = range(0, len(ElectricalWindData))
ElectricalWindTableHeadder = "#1\ndouble windGeneration(8784,2)\n"
with open('CombiTableFiles/CountryWindGeneration.txt','w') as fileObject5:
    fileObject5.write(ElectricalWindTableHeadder)
ElectricalWindData.to_csv('CombiTableFiles/CountryWindGeneration.txt', header=None, index=None, sep='\t', mode='a+')