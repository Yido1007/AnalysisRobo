class Api {
  splash() async {
    return await Future.delayed(const Duration(milliseconds: 800), () {
      return {
        "background":
            "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/b547b5111139045.5ffc8a2ab537c.jpg",
        "backgroundColor": "FFFFFF",
        "logo":
            "https://cdn3.iconfinder.com/data/icons/2018-social-media-logotypes/1000/2018_social_media_popular_app_logo_instagram-512.png",
        "duration": 2500,
      };
    });
  }
}
