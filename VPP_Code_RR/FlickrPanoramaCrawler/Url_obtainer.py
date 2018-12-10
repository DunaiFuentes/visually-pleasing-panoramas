import flickrapi

api_key = u'888d850723d9d8b71858dc1080adc78d'
api_secret = u'96ab0837676e58bf'

# Change path for your own
f = open('C:/Users/Dunai/Desktop/VPP_Data_RR/FlickrPanoramaCrawler/CrawlerOuputFile_b.txt', 'w')

x = 0
flickr = flickrapi.FlickrAPI(api_key, api_secret,format='etree')
for photo in flickr.walk(
        tags='panorama',
        min_taken_date='2015-01-20',
 #       max_taken_date='2015-08-30'
        ):
    Server = photo.get('server')
    ID = photo.get('id')
    Farm = photo.get('farm')
    Secret = photo.get('secret')
    size_pic = 'b'

    url = "https://farm" + Farm + '.staticflickr.com/' + Server + '/' + ID + '_' + Secret + '_' + size_pic + '.jpg'

    favorites = flickr.photos.getFavorites(photo_id = ID)
    photo = favorites.getchildren()
    photo1 = photo.pop()
    list_of_favs = photo1.findall('person')
    num_favs = len(list_of_favs)

    x = x+1
    if x > 1000:
        break

    print(x)
    print(num_favs)
    print(url)

    f.write(str(x) + ' ' +  url + ' ' + str(num_favs) + '\n')

f.close()