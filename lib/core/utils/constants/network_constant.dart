// ignore_for_file: constant_identifier_names

// BASE URL
const BASE_URL = "api.themoviedb.org";
const VERSION = 3;
const MOVIE_DOMAIN = "/movie";
const TV_DOMAIN = "/tv";

const UPCOMING = "/upcoming";
const NOW_PLAYING = "/now_playing";

const POPULAR = "/popular";
const TOP_RATED = "/top_rated";
const AIRING_TODAY = "/airing_today";

const HEADERS = {
  'Content-Type': 'application/json; charset=UTF-8',
  'Accept': 'application/json',
};


//"https://api.themoviedb.org/3/movie/<movieId>/similar?api_key=<apiKey>"
//"https://api.themoviedb.org/3/movie/<movieId>/recommendations?api_key=<apiKey>"
//"https://api.themoviedb.org/3/movie/<movieId>/images?api_key=<apiKey>"
//"https://api.themoviedb.org/3/search/movie?query=<query>&api_key=<apiKey>"