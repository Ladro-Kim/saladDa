// success:               returned when JSON file was generated successfully.
// call_limit_reached:    returned when minute/monthly limit is reached.
// api_key_expired:       returned when API key is expired.
// incorrect_api_key:     returned when using wrong API key.
// ip_location_failed:    returned when service is unable to locate IP address of request.
// no_nearest_station:    returned when there is no nearest station within specified radius.
// feature_not_available: returned when call requests a feature that is not available in chosen subscription plan.
// too_many_requests:     returned when more than 10 calls per second are made.

class WeatherData {
  String status;
  Data data;

  WeatherData({this.status, this.data});

  WeatherData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String city;
  String state;
  String country;
  Location location;
  List<Forecasts> forecasts;
  Current current;
  History history;

  Data(
      {this.city,
        this.state,
        this.country,
        this.location,
        this.forecasts,
        this.current,
        this.history});

  Data.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    country = json['country'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    if (json['forecasts'] != null) {
      forecasts = <Forecasts>[];
      json['forecasts'].forEach((v) {
        forecasts.add(Forecasts.fromJson(v));
      });
    }
    current =
    json['current'] != null ? Current.fromJson(json['current']) : null;
    history =
    json['history'] != null ? History.fromJson(json['history']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.forecasts != null) {
      data['forecasts'] = this.forecasts.map((v) => v.toJson()).toList();
    }
    if (this.current != null) {
      data['current'] = this.current.toJson();
    }
    if (this.history != null) {
      data['history'] = this.history.toJson();
    }
    return data;
  }
}

class Location {
  String type;
  List<num> coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<num>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Forecasts {
  String ts;
  int aqius;
  int aqicn;
  int tp;
  int tpMin;
  int pr;
  int hu;
  int ws;
  int wd;
  String ic;

  Forecasts(
      {this.ts,
        this.aqius,
        this.aqicn,
        this.tp,
        this.tpMin,
        this.pr,
        this.hu,
        this.ws,
        this.wd,
        this.ic});

  Forecasts.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    aqius = json['aqius'];
    aqicn = json['aqicn'];
    tp = json['tp'];
    tpMin = json['tp_min'];
    pr = json['pr'];
    hu = json['hu'];
    ws = json['ws'];
    wd = json['wd'];
    ic = json['ic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ts'] = this.ts;
    data['aqius'] = this.aqius;
    data['aqicn'] = this.aqicn;
    data['tp'] = this.tp;
    data['tp_min'] = this.tpMin;
    data['pr'] = this.pr;
    data['hu'] = this.hu;
    data['ws'] = this.ws;
    data['wd'] = this.wd;
    data['ic'] = this.ic;
    return data;
  }
}

class Current {
  Weather weather;
  Pollution pollution;

  Current({this.weather, this.pollution});

  Current.fromJson(Map<String, dynamic> json) {
    weather =
    json['weather'] != null ? Weather.fromJson(json['weather']) : null;
    pollution = json['pollution'] != null
        ? Pollution.fromJson(json['pollution'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.weather != null) {
      data['weather'] = this.weather.toJson();
    }
    if (this.pollution != null) {
      data['pollution'] = this.pollution.toJson();
    }
    return data;
  }
}

class Weather {
  String ts;
  int tp;
  int pr;
  int hu;
  num ws;
  int wd;
  String ic;

  Weather({this.ts, this.tp, this.pr, this.hu, this.ws, this.wd, this.ic});

  Weather.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    tp = json['tp'];
    pr = json['pr'];
    hu = json['hu'];
    ws = json['ws'];
    wd = json['wd'];
    ic = json['ic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ts'] = this.ts;
    data['tp'] = this.tp;
    data['pr'] = this.pr;
    data['hu'] = this.hu;
    data['ws'] = this.ws;
    data['wd'] = this.wd;
    data['ic'] = this.ic;
    return data;
  }
}

class Pollution {
  String ts;
  int aqius;
  String mainus;
  int aqicn;
  String maincn;
  P2 p2;

  Pollution(
      {this.ts, this.aqius, this.mainus, this.aqicn, this.maincn, this.p2});

  Pollution.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    aqius = json['aqius'];
    mainus = json['mainus'];
    aqicn = json['aqicn'];
    maincn = json['maincn'];
    p2 = json['p2'] != null ? P2.fromJson(json['p2']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ts'] = this.ts;
    data['aqius'] = this.aqius;
    data['mainus'] = this.mainus;
    data['aqicn'] = this.aqicn;
    data['maincn'] = this.maincn;
    if (this.p2 != null) {
      data['p2'] = this.p2.toJson();
    }
    return data;
  }
}

class P2 {
  num conc;
  int aqius;
  int aqicn;

  P2({this.conc, this.aqius, this.aqicn});

  P2.fromJson(Map<String, dynamic> json) {
    conc = json['conc'];
    aqius = json['aqius'];
    aqicn = json['aqicn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['conc'] = this.conc;
    data['aqius'] = this.aqius;
    data['aqicn'] = this.aqicn;
    return data;
  }
}

class History {
  List<Weather> weather;
  List<Pollution> pollution;

  History({this.weather, this.pollution});

  History.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }
    if (json['pollution'] != null) {
      pollution = <Pollution>[];
      json['pollution'].forEach((v) {
        pollution.add(Pollution.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.weather != null) {
      data['weather'] = this.weather.map((v) => v.toJson()).toList();
    }
    if (this.pollution != null) {
      data['pollution'] = this.pollution.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


// {
// "status": "success",
// "data": {
// "city": "Port Harcourt",
// "state": "Rivers",
// "country": "Nigeria",
// "location": {
// "type": "Point",
// "coordinates": [
// 7.048623,
// 4.854166
// ]
// },
// "forecasts": [
// {
// "ts": "2019-08-15T12:00:00.000Z",
// "aqius": 137,
// "aqicn": 69,
// "tp": 23,
// "tp_min": 23,
// "pr": 996,
// "hu": 100,
// "ws": 2,
// "wd": 225,
// "ic": "10d"
// },