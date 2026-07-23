#!/usr/bin/env python3
import json
import urllib.request
import sys

WEATHER_ICONS = {
    '113': '󰖙', # Sunny / Clear
    '116': '󰖕', # Partly cloudy
    '119': '󰖐', # Cloudy
    '122': '󰖐', # Overcast
    '143': '󰌵', # Fog
    '176': '󰖗', # Patchy rain nearby
    '179': '󰼶', # Patchy snow nearby
    '182': '󰙿', # Patchy sleet nearby
    '185': '󰙿', # Patchy freezing drizzle nearby
    '200': '󰙾', # Thundery outbreaks nearby
    '227': '󰼶', # Blowing snow
    '230': '󰼶', # Blizzard
    '248': '󰌵', # Fog
    '260': '󰌵', # Freezing fog
    '263': '󰖗', # Patchy light drizzle
    '266': '󰖗', # Light drizzle
    '281': '󰙿', # Freezing drizzle
    '284': '󰙿', # Heavy freezing drizzle
    '293': '󰖗', # Patchy light rain
    '296': '󰖗', # Light rain
    '299': '󰖖', # Moderate rain at times
    '302': '󰖖', # Moderate rain
    '305': '󰖖', # Heavy rain at times
    '308': '󰖖', # Heavy rain
    '311': '󰙿', # Light freezing rain
    '314': '󰙿', # Moderate or heavy freezing rain
    '317': '󰙿', # Light sleet
    '320': '󰙿', # Moderate or heavy sleet
    '323': '󰼶', # Patchy light snow
    '326': '󰼶', # Light snow
    '329': '󰼶', # Patchy moderate snow
    '332': '󰼶', # Moderate snow
    '335': '󰼶', # Patchy heavy snow
    '338': '󰼶', # Heavy snow
    '350': '󰙿', # Ice pellets
    '353': '󰖗', # Light rain shower
    '356': '󰖖', # Moderate or heavy rain shower
    '359': '󰖖', # Torrential rain shower
    '362': '󰙿', # Light sleet showers
    '365': '󰙿', # Moderate or heavy sleet showers
    '368': '󰼶', # Light snow showers
    '371': '󰼶', # Moderate or heavy snow showers
    '374': '󰙿', # Light showers of ice pellets
    '377': '󰙿', # Moderate or heavy showers of ice pellets
    '386': '󰙾', # Patchy light rain with thunder
    '389': '󰙾', # Moderate or heavy rain with thunder
    '392': '󰙾', # Patchy light snow with thunder
    '395': '󰼶'  # Moderate or heavy snow with thunder
}

def main():
    try:
        req = urllib.request.Request(
            "https://wttr.in/?format=j1",
            headers={"User-Agent": "Mozilla/5.0"}
        )
        with urllib.request.urlopen(req, timeout=10) as response:
            data = json.loads(response.read().decode('utf-8'))
        
        current = data['current_condition'][0]
        nearest_area = data['nearest_area'][0]
        
        code = current.get('weatherCode', '113')
        icon = WEATHER_ICONS.get(code, '󰖙')
        temp_c = current.get('temp_C', '0')
        feels_like_c = current.get('FeelsLikeC', temp_c)
        desc = current.get('weatherDesc', [{}])[0].get('value', '')
        humidity = current.get('humidity', '0')
        wind_kmh = current.get('windspeedKmph', '0')
        
        city = nearest_area.get('areaName', [{}])[0].get('value', 'Unknown')
        country = nearest_area.get('country', [{}])[0].get('value', '')
        
        location_str = f"{city}, {country}" if country else city
        
        text = f"{icon} {temp_c}°C"
        
        tooltip = (
            f"<b>{location_str}</b>\n"
            f"Condition: {desc}\n"
            f"Temperature: {temp_c}°C (Feels like {feels_like_c}°C)\n"
            f"Humidity: {humidity}%\n"
            f"Wind: {wind_kmh} km/h"
        )
        
        if 'weather' in data and len(data['weather']) > 0:
            tooltip += "\n\n<b>Forecast:</b>"
            for day in data['weather'][:3]:
                date = day.get('date', '')
                max_t = day.get('maxtempC', '')
                min_t = day.get('mintempC', '')
                cond = day.get('hourly', [{}])[4].get('weatherDesc', [{}])[0].get('value', '')
                tooltip += f"\n• {date}: {min_t}°C - {max_t}°C, {cond}"

        print(json.dumps({"text": text, "tooltip": tooltip, "class": "weather"}))
    except Exception as e:
        print(json.dumps({"text": "󰖙 N/A", "tooltip": f"Weather unavailable: {str(e)}", "class": "weather-error"}))

if __name__ == "__main__":
    main()
