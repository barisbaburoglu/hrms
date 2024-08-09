class Parcel {
  final String? ilceAd;
  final String? mevkii;
  final int? ilId;
  final String? durum;
  final int? ilceId;
  final String? zeminKmdurum;
  final String? parselNo;
  final String? mahalleAd;
  final String? ozet;
  final String? gittigiParselListe;
  final String? gittigiParselSebep;
  final String? alan;
  final String? adaNo;
  final String? nitelik;
  final String? ilAd;
  final int? mahalleId;
  final String? pafta;
  final List<List<LatLngModel>>? coordinates;

  Parcel({
    this.ilceAd,
    this.mevkii,
    this.ilId,
    this.durum,
    this.ilceId,
    this.zeminKmdurum,
    this.parselNo,
    this.mahalleAd,
    this.ozet,
    this.gittigiParselListe,
    this.gittigiParselSebep,
    this.alan,
    this.adaNo,
    this.nitelik,
    this.ilAd,
    this.mahalleId,
    this.pafta,
    this.coordinates,
  });

  factory Parcel.fromJson(Map<String, dynamic> json) {
    List<List<LatLngModel>>? parseCoordinates(List? coordsJson) {
      if (coordsJson == null) return null;
      return coordsJson.map((i) {
        return (i as List).map((j) {
          final latLng = (j as List).map((k) => k.toDouble()).toList();
          return LatLngModel(
              latLng[1], latLng[0]); // LatLng expects (latitude, longitude)
        }).toList();
      }).toList();
    }

    return Parcel(
      ilceAd: json['properties']['ilceAd'] as String?,
      mevkii: json['properties']['mevkii'] as String?,
      ilId: json['properties']['ilId'] as int?,
      durum: json['properties']['durum'] as String?,
      ilceId: json['properties']['ilceId'] as int?,
      zeminKmdurum: json['properties']['zeminKmdurum'] as String?,
      parselNo: json['properties']['parselNo'] as String?,
      mahalleAd: json['properties']['mahalleAd'] as String?,
      ozet: json['properties']['ozet'] as String?,
      gittigiParselListe: json['properties']['gittigiParselListe'] as String?,
      gittigiParselSebep: json['properties']['gittigiParselSebep'] as String?,
      alan: json['properties']['alan'] as String?,
      adaNo: json['properties']['adaNo'] as String?,
      nitelik: json['properties']['nitelik'] as String?,
      ilAd: json['properties']['ilAd'] as String?,
      mahalleId: json['properties']['mahalleId'] as int?,
      pafta: json['properties']['pafta'] as String?,
      coordinates: parseCoordinates(json['geometry']['coordinates'] as List?),
    );
  }
}

class LatLngModel {
  final double latitude;
  final double longitude;

  LatLngModel(this.latitude, this.longitude);
}
