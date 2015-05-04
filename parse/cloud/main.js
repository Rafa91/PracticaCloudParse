
var Image = require("parse-image");
 
Parse.Cloud.beforeSave("News", function(request, response){
 
    // damos por sentado que la propiedad que almacena la foto se llama photo
    
    var myNews = request.object;
 
    if (!myNews.get("photo")) {
        //checkin.save();
        response.success();
    } else {
 
            Parse.Cloud.httpRequest({
                url: myNews.get("photo").url()
            }).then(function(response){
                var image = new Image();
                return image.setData(response.buffer);
            }).then(function (image){
 
                return image.scale({ 
                    width: 128,
                    height: 128}
                    )
            }).then(function(image){
                return image.setFormat("JPEG");
            }).then(function(image){
                return image.data();
            }).then(function(buffer){
                var base64 = buffer.toString("base64");
                var cropped = new Parse.File("Thumbnail.jpg", {base64: base64});
                return cropped.save();
            }).then(function(cropped){
                myNews.set("photoThumbnail", cropped);
 
            }).then(function(result){
                response.success();
            }, function(error){
                response.error(error);
            });
        }
     
});


Parse.Cloud.job("userMigration", function(request, status) {

  var counter = 0;
  // Query for all News
  var query = new Parse.Query("News");
  query.equalTo("state", 2);
  query.each(function(notice) {
    //if (notice.get("state") == 2) {
        notice.set("state", 1);
    //};
      counter += 1;
      notice.save();
  }).then(function() {
    // Set the job's success status
    status.success("publicacion terminada con éxito");
  }, function(error) {
    // Set the job's error status
    status.error("Uh oh, something went wrong.");
  });
});