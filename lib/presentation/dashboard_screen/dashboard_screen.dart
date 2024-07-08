import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../models/movie.dart'; // Import the Movie model

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<Movie>? futureMovie;
  String? userName;

  @override
  void initState() {
    super.initState();
    _loadUserProfileName();
    futureMovie = fetchTopMovie();
  }

  Future<Movie> fetchTopMovie() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5YTgxZjM0YzU3ZDNkYzhmYTdmMDNjODA4ZjU2ZTlkMiIsIm5iZiI6MTcyMDQxNzEwMi41OTg3NDIsInN1YiI6IjY2OGI3OTkzMDQ3YTMwYzc0ODk4Y2I0YiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kwyYDz2mirPAAIgZz03C544bdY_ROp8qsKy1wHvjuhY', // Replace with your actual API key
        'accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      List<Movie> movies = moviesFromJson(response.body);
      return movies.first;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<void> _loadUserProfileName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString('user_name');
    setState(() {
      userName = storedName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBarWelcome(context),
        body: futureMovie == null
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    futureMovie = fetchTopMovie();
                  });
                },
                child: FutureBuilder<Movie>(
                  future: futureMovie,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: _buildMovieCard(context, snapshot.data!),
                      );
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  },
                ),
              ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBarWelcome(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "Welcome",
        margin: EdgeInsets.only(left: 21),
      ),
      actions: [
        AppbarSubtitle(
          text: userName ?? "User Name",
          margin: EdgeInsets.fromLTRB(15, 21, 5, 12),
        ),
        SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.profileScreen);
          },
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.png'),
            radius: 20,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            child: Image.asset('assets/images/avatar.png'),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieCard(BuildContext context, Movie movie) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.symmetric(horizontal: 17, vertical: 28),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: AppDecoration.fillGreen.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: CustomTextStyles.titleMediumOnPrimary,
          ),
          SizedBox(height: 8),
          Center(
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              height: 200,
            ),
          ),
          SizedBox(height: 8),
          Text(
            movie.overview,
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
          SizedBox(height: 8),
          Text(
            "Release Date: ${movie.releaseDate}",
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
          SizedBox(height: 8),
          Text(
            "Rating: ${movie.voteAverage}",
            style: CustomTextStyles.bodyMediumOnPrimary,
          ),
        ],
      ),
    );
  }
}
