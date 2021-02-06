require 'net/http'
require 'uri'

def cleaning
  puts "Cleaning database..."
  Sentence.destroy_all
  Song.destroy_all
  Word.destroy_all
  Artist.destroy_all
end

cleaning

def compute_artist_info(artist_info)
  {
    name: artist_info.name,
    image: artist_info.image_url,
    genius_id: artist_info.id,
    genius_url: artist_info.url
  }
end

def compute_song_info(song_info, artist)
  {
    artist: artist,
    name: song_info.title,
    image: song_info.song_art_image_url,
    genius_id: song_info.id,
    genius_url: song_info.url
    # release_date: nil
    # album: nil
    # genius_views: nil
  }
end

def compute_sentence_info(lyric_matching, song, word)
  {
    content: lyric_matching.first.value,
    song: song,
    word: word
  }
end

def create_elements_for_current_page(hits, word)
  hits.each do |hit|
    lyric_match = hit.highlights
    song_info = hit.result
    artist_info = song_info.primary_artist
    
    current_artist = Artist.find_or_create_by(compute_artist_info(artist_info))
    if current_artist.valid?
      current_song = Song.find_or_create_by(compute_song_info(song_info, current_artist))
      current_song.get_genius_info
      current_sentence = Sentence.find_or_create_by(compute_sentence_info(lyric_match, current_song, word))
    end
  end
end

def get_genius_search_results(page, word)
    sentence_count_beginning = Sentence.count

    uri = URI.parse("https://genius.com/api/search/lyric?page=#{page}&q=' #{word.name} '")
    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0"
    request["Accept"] = "application/json, text/plain, */*"
    request["Accept-Language"] = "en-US,en;q=0.5"
    request["X-Requested-With"] = "XMLHttpRequest"
    request["Connection"] = "keep-alive"
    request["Cookie"] = "_genius_ab_test_cohort=80; _fbp=fb.1.1606487319891.633184117; _cb_ls=1; _cb=Bmb39SDPaysjB7iMz-; _chartbeat2=.1599811440613.1611854394368.0000000001000001.B-POZzC0A32KCEKvu1DwYZlyD2pGG0.2; _ga=GA1.2.1310822660.1606487321; OptanonConsent=isIABGlobal=false&datestamp=Thu+Jan+28+2021+18%3A19%3A53+GMT%2B0100+(Central+European+Standard+Time)&version=6.6.0&hosts=&consentId=597b1e36-ca33-43ea-a212-d0025457bfac&interactionCount=1&landingPath=NotLandingPage&groups=C0002%3A1%2CC0001%3A1%2CSTACK42%3A1&geolocation=FR%3BIDF&AwaitingReconsent=false; OptanonAlertBoxClosed=2020-11-27T14:28:42.579Z; eupubconsent-v2=CO9ioL7O9ioL7AcABBENBCCoAP_AAH_AAChQHItf_X_fb3_j-_59_9t0eY1f9_7_v20zjgeds-8Nyd_X_L8X42M7vB36pq4KuR4Eu3LBIQdlHOHcTUmw6IkVqTPsbk2Mr7NKJ7PEinMbe2dYGH9_n9XTuZKY79_s___z__-__v__7_f_r-3_3_vp9V---3YHIgEmGpfARZiWOBJNGlUKIEIVxIdACACihGFomsICVwU7K4CP0EDABAagIwIgQYgoxZBAAAAAElEQEgB4IBEARAIAAQAqQEIACNAEFgBIGAQACgGhYARQBCBIQZHBUcpgQESLRQTyVgCUXexhhCGUUANAg4AA.YAAAAAAAAAAA; __qca=P0-2110512006-1606487319875; __gads=ID=df55777c4d5575bd:T=1606487322:S=ALNI_MZbxqr0rVOJWrPm_hcOvxKeMFBGag; __cfduid=d08dc9732032cafc591cbc13b84cfab101609756220; _csrf_token=tZC5xQl%2F7GHfzRoj2boRJi2v1WkBuBErQbVJ9n2NYX4%3D; user_credentials=559061b56052a612649be23eadca364bad79016b06158a219e73e9b057c2ffd52a26dbd829df607d6f5eb46bd3f8d32d9596d3c7cbdb39bbf6ae718ac448fc49%3A%3A12646954; no_public_cache=true; mp_ba3361519af2d79b0d3ff6ce08f24f4d_mixpanel=%7B%22distinct_id%22%3A%20%22176cd14d7da108-0855e36fb423c88-4c3f207e-e1000-176cd14d7db30c%22%2C%22%24device_id%22%3A%20%22176cd14d7da108-0855e36fb423c88-4c3f207e-e1000-176cd14d7db30c%22%2C%22%24initial_referrer%22%3A%20%22https%3A%2F%2Fgenius.com%2Fsearch%3Fq%3Dkichta%22%2C%22%24initial_referring_domain%22%3A%20%22genius.com%22%7D; _gid=GA1.2.2038438766.1611854377; _gat=1; _rapgenius_session=BAh7CToPc2Vzc2lvbl9pZEkiJWUwZTE2Yjg5ZmUwNTZlMzk3MTM5MTNhNGY5MTJiYmQwBjoGRUZJIhV1c2VyX2NyZWRlbnRpYWxzBjsGVEkiAYA1NTkwNjFiNTYwNTJhNjEyNjQ5YmUyM2VhZGNhMzY0YmFkNzkwMTZiMDYxNThhMjE5ZTczZTliMDU3YzJmZmQ1MmEyNmRiZDgyOWRmNjA3ZDZmNWViNDZiZDNmOGQzMmQ5NTk2ZDNjN2NiZGIzOWJiZjZhZTcxOGFjNDQ4ZmM0OQY7BlRJIhh1c2VyX2NyZWRlbnRpYWxzX2lkBjsGVGkDKvrAOhBfY3NyZl90b2tlbkkiMXRaQzV4UWwvN0dIZnpSb2oyYm9SSmkydjFXa0J1QkVyUWJWSjluMk5ZWDQ9BjsGRg%3D%3D--b68954f7f53d8911c7b8e7228728307adb29a21e; AMP_TOKEN=%24NOT_FOUND; _cb_svref=null; no_public_cache=true; mp_mixpanel__c=0; mp_77967c52dc38186cc1aadebdd19e2a82_mixpanel=%7B%22distinct_id%22%3A%2012646954%2C%22%24device_id%22%3A%20%221760a1b25741f7-0fac2f2a37b7528-4c3f2779-e1000-1760a1b2575691%22%2C%22%24search_engine%22%3A%20%22google%22%2C%22%24initial_referrer%22%3A%20%22https%3A%2F%2Fwww.google.com%2F%22%2C%22%24initial_referring_domain%22%3A%20%22www.google.com%22%2C%22Logged%20In%22%3A%20true%2C%22Is%20Editor%22%3A%20false%2C%22Is%20Moderator%22%3A%20false%2C%22Mobile%20Site%22%3A%20false%2C%22AMP%22%3A%20false%2C%22Tag%22%3A%20%22rap%22%2C%22genius_platform%22%3A%20%22web%22%2C%22%24user_id%22%3A%2012646954%7D; flash=%7B%7D; _chartbeat5=162,1365,%2Fsearch%3Fq%3Dmoula,https%3A%2F%2Fgenius.com%2F,8xPXrBDnqqHBUFQCMCCDrElBYHa6F,,c,8xPXrBDnqqHBUFQCMCCDrElBYHa6F,genius.com,"
  
    req_options = {
      use_ssl: uri.scheme == "https",
    }
  
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    
    result = JSON.parse(response.body, object_class: OpenStruct).response
  
    hits = result.sections.first.hits
    create_elements_for_current_page(hits, word)

    sentence_count_end = Sentence.count
    puts "#{sentence_count_end - sentence_count_beginning} sentences added, total : #{Sentence.count}"
    if result.next_page
      page = result.next_page
      get_genius_search_results(page, word)
    end
  end
  
  moula = Word.create!(name: "moula")
  get_genius_search_results(1, moula)