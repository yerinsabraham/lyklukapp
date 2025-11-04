class MusicTrack {
    MusicTrack({
        required this.id,
        required this.name,
        required this.duration,
        required this.artistId,
        required this.artistName,
        required this.artistIdstr,
        required this.albumName,
        required this.albumId,
        required this.licenseCcurl,
        required this.position,
        required this.releasedate,
        required this.albumImage,
        required this.audio,
        required this.audiodownload,
        required this.prourl,
        required this.shorturl,
        required this.shareurl,
        required this.waveform,
        required this.image,
        required this.musicinfo,
        required this.audiodownloadAllowed,
    });

    final String? id;
    final String? name;
    final int? duration;
    final String? artistId;
    final String? artistName;
    final String? artistIdstr;
    final String? albumName;
    final String? albumId;
    final String? licenseCcurl;
    final int? position;
    final DateTime? releasedate;
    final String? albumImage;
    final String? audio;
    final String? audiodownload;
    final String? prourl;
    final String? shorturl;
    final String? shareurl;
    final Waveform? waveform;
    final String? image;
    final Musicinfo? musicinfo;
    final bool? audiodownloadAllowed;

    MusicTrack copyWith({
        String? id,
        String? name,
        int? duration,
        String? artistId,
        String? artistName,
        String? artistIdstr,
        String? albumName,
        String? albumId,
        String? licenseCcurl,
        int? position,
        DateTime? releasedate,
        String? albumImage,
        String? audio,
        String? audiodownload,
        String? prourl,
        String? shorturl,
        String? shareurl,
        Waveform? waveform,
        String? image,
        Musicinfo? musicinfo,
        bool? audiodownloadAllowed,
    }) {
        return MusicTrack(
            id: id ?? this.id,
            name: name ?? this.name,
            duration: duration ?? this.duration,
            artistId: artistId ?? this.artistId,
            artistName: artistName ?? this.artistName,
            artistIdstr: artistIdstr ?? this.artistIdstr,
            albumName: albumName ?? this.albumName,
            albumId: albumId ?? this.albumId,
            licenseCcurl: licenseCcurl ?? this.licenseCcurl,
            position: position ?? this.position,
            releasedate: releasedate ?? this.releasedate,
            albumImage: albumImage ?? this.albumImage,
            audio: audio ?? this.audio,
            audiodownload: audiodownload ?? this.audiodownload,
            prourl: prourl ?? this.prourl,
            shorturl: shorturl ?? this.shorturl,
            shareurl: shareurl ?? this.shareurl,
            waveform: waveform ?? this.waveform,
            image: image ?? this.image,
            musicinfo: musicinfo ?? this.musicinfo,
            audiodownloadAllowed: audiodownloadAllowed ?? this.audiodownloadAllowed,
        );
    }

    factory MusicTrack.fromJson(Map<String, dynamic> json){ 
        return MusicTrack(
            id: json["id"],
            name: json["name"],
            duration: json["duration"],
            artistId: json["artist_id"],
            artistName: json["artist_name"],
            artistIdstr: json["artist_idstr"],
            albumName: json["album_name"],
            albumId: json["album_id"],
            licenseCcurl: json["license_ccurl"],
            position: json["position"],
            releasedate: DateTime.tryParse(json["releasedate"] ?? ""),
            albumImage: json["album_image"],
            audio: json["audio"],
            audiodownload: json["audiodownload"],
            prourl: json["prourl"],
            shorturl: json["shorturl"],
            shareurl: json["shareurl"],
            waveform: json["waveform"] == null ? null : Waveform.fromJson(json["waveform"]),
            image: json["image"],
            musicinfo: json["musicinfo"] == null ? null : Musicinfo.fromJson(json["musicinfo"]),
            audiodownloadAllowed: json["audiodownload_allowed"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "artist_id": artistId,
        "artist_name": artistName,
        "artist_idstr": artistIdstr,
        "album_name": albumName,
        "album_id": albumId,
        "license_ccurl": licenseCcurl,
        "position": position,
        "releasedate": releasedate?.toIso8601String(),
        "album_image": albumImage,
        "audio": audio,
        "audiodownload": audiodownload,
        "prourl": prourl,
        "shorturl": shorturl,
        "shareurl": shareurl,
        "waveform": waveform?.toJson(),
        "image": image,
        "musicinfo": musicinfo?.toJson(),
        "audiodownload_allowed": audiodownloadAllowed,
    };

    @override
    String toString(){
        return "$id, $name, $duration, $artistId, $artistName, $artistIdstr, $albumName, $albumId, $licenseCcurl, $position, $releasedate, $albumImage, $audio, $audiodownload, $prourl, $shorturl, $shareurl, $waveform, $image, $musicinfo, $audiodownloadAllowed, ";
    }
}

class Musicinfo {
    Musicinfo({
        required this.vocalinstrumental,
        required this.lang,
        required this.gender,
        required this.acousticelectric,
        required this.speed,
        required this.tags,
    });

    final String? vocalinstrumental;
    final String? lang;
    final String? gender;
    final String? acousticelectric;
    final String? speed;
    final Tags? tags;

    Musicinfo copyWith({
        String? vocalinstrumental,
        String? lang,
        String? gender,
        String? acousticelectric,
        String? speed,
        Tags? tags,
    }) {
        return Musicinfo(
            vocalinstrumental: vocalinstrumental ?? this.vocalinstrumental,
            lang: lang ?? this.lang,
            gender: gender ?? this.gender,
            acousticelectric: acousticelectric ?? this.acousticelectric,
            speed: speed ?? this.speed,
            tags: tags ?? this.tags,
        );
    }

    factory Musicinfo.fromJson(Map<String, dynamic> json){ 
        return Musicinfo(
            vocalinstrumental: json["vocalinstrumental"],
            lang: json["lang"],
            gender: json["gender"],
            acousticelectric: json["acousticelectric"],
            speed: json["speed"],
            tags: json["tags"] == null ? null : Tags.fromJson(json["tags"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "vocalinstrumental": vocalinstrumental,
        "lang": lang,
        "gender": gender,
        "acousticelectric": acousticelectric,
        "speed": speed,
        "tags": tags?.toJson(),
    };

    @override
    String toString(){
        return "$vocalinstrumental, $lang, $gender, $acousticelectric, $speed, $tags, ";
    }
}

class Tags {
    Tags({
        required this.genres,
        required this.instruments,
        required this.vartags,
    });

    final List<String> genres;
    final List<dynamic> instruments;
    final List<String> vartags;

    Tags copyWith({
        List<String>? genres,
        List<dynamic>? instruments,
        List<String>? vartags,
    }) {
        return Tags(
            genres: genres ?? this.genres,
            instruments: instruments ?? this.instruments,
            vartags: vartags ?? this.vartags,
        );
    }

    factory Tags.fromJson(Map<String, dynamic> json){ 
        return Tags(
            genres: json["genres"] == null ? [] : List<String>.from(json["genres"]!.map((x) => x)),
            instruments: json["instruments"] == null ? [] : List<dynamic>.from(json["instruments"]!.map((x) => x)),
            vartags: json["vartags"] == null ? [] : List<String>.from(json["vartags"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "genres": genres.map((x) => x).toList(),
        "instruments": instruments.map((x) => x).toList(),
        "vartags": vartags.map((x) => x).toList(),
    };

    @override
    String toString(){
        return "$genres, $instruments, $vartags, ";
    }
}

class Waveform {
    Waveform({
        required this.peaks,
    });

    final List<int> peaks;

    Waveform copyWith({
        List<int>? peaks,
    }) {
        return Waveform(
            peaks: peaks ?? this.peaks,
        );
    }

    factory Waveform.fromJson(Map<String, dynamic> json){ 
        return Waveform(
            peaks: json["peaks"] == null ? [] : List<int>.from(json["peaks"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "peaks": peaks.map((x) => x).toList(),
    };

    @override
    String toString(){
        return "$peaks, ";
    }
}
