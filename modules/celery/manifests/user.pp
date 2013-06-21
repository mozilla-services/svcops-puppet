class celery::user {
# Add a default celery user if one is not defined
  base::user{
    'celery':
      uid => '2000'
  }
}
