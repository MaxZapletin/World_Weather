import unittest
from unittest.mock import patch
from flask import Flask, request, jsonify
from app import app, get_weather

class WeatherAppTestCase(unittest.TestCase):
    def setUp(self):
        # Set up the test client
        self.app = app.test_client()
        self.app.testing = True

    @patch('requests.get')
    def test_index_no_city(self, mock_get):
        # Test the index route without providing a city
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'<form method="GET" action="/">', response.data)

    @patch('requests.get')
    def test_index_with_city_html(self, mock_get):
        # Mock the API response
        mock_get.return_value.status_code = 200
        mock_get.return_value.json.return_value = {
            "location": {
                "name": "London",
                "country": "UK"
            },
            "current": {
                "temp_c": 20,
                "condition": {"text": "Sunny", "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"}
            },
            "forecast": {
                "forecastday": [
                    {
                        "date": "2023-07-15",
                        "day": {
                            "maxtemp_c": 22,
                            "mintemp_c": 15,
                            "condition": {"text": "Partly cloudy", "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"}
                        }
                    }
                ]
            }
        }

        # Test the index route with a city
        response = self.app.get('/?city=London')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Weather for London, UK', response.data)
        self.assertIn(b'Current temperature: 20\xc2\xb0C', response.data)

    @patch('requests.get')
    def test_index_with_city_json(self, mock_get):
        # Mock the API response
        mock_get.return_value.status_code = 200
        mock_get.return_value.json.return_value = {
            "location": {
                "name": "London",
                "country": "UK"
            },
            "current": {
                "temp_c": 20,
                "condition": {"text": "Sunny", "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"}
            },
            "forecast": {
                "forecastday": [
                    {
                        "date": "2023-07-15",
                        "day": {
                            "maxtemp_c": 22,
                            "mintemp_c": 15,
                            "condition": {"text": "Partly cloudy", "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"}
                        }
                    }
                ]
            }
        }

        # Test the index route with a city and JSON response
        response = self.app.get('/?city=London', headers={'Accept': 'application/json'})
        self.assertEqual(response.status_code, 200)
        json_data = response.get_json()
        self.assertEqual(json_data['location'], 'London')
        self.assertEqual(json_data['country'], 'UK')
        self.assertEqual(json_data['current']['temp_c'], 20)

    @patch('requests.get')
    def test_get_weather_success(self, mock_get):
        # Mock the API response
        mock_get.return_value.status_code = 200
        mock_get.return_value.json.return_value = {
            "location": {
                "name": "London",
                "country": "UK"
            },
            "current": {
                "temp_c": 20,
                "condition": {"text": "Sunny", "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"}
            },
            "forecast": {
                "forecastday": [
                    {
                        "date": "2023-07-15",
                        "day": {
                            "maxtemp_c": 22,
                            "mintemp_c": 15,
                            "condition": {"text": "Partly cloudy", "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"}
                        }
                    }
                ]
            }
        }

        # Test the get_weather function
        weather_data = get_weather('London')
        self.assertIsNotNone(weather_data)
        self.assertEqual(weather_data['location'], 'London')
        self.assertEqual(weather_data['country'], 'UK')
        self.assertEqual(weather_data['current']['temp_c'], 20)

    @patch('requests.get')
    def test_get_weather_failure(self, mock_get):
        # Mock the API response
        mock_get.return_value.status_code = 404

        # Test the get_weather function with a non-existent city
        weather_data = get_weather('UnknownCity')
        self.assertIsNone(weather_data)

if __name__ == '__main__':
    unittest.main()
