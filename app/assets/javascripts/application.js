
//$(this).find(":selected").attr('data-type')
//google key api  AIzaSyBHh98RBg7JmbuGfuIVITP1uJRfAAiKspM
//text = text.replace(" ","+")

//$('#container').html('<blockquote class="twitter-tweet"><a href="https://twitter.com/Interior/status/507185938620219395"></a></blockquote><blockquote class="twitter-tweet"><a href="https://twitter.com/Kem_WD/status/756167143578738689"></a></blockquote><blockquote class="twitter-tweet"><a href="https://twitter.com/DribbbleBest/status/756069290181296128"></a></blockquote><blockquote class="twitter-tweet"><a href="https://twitter.com/Kem_WD/status/756067361816469504"></a></blockquote><script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>');

function accueil() {
    window.location.assign('/');
}

function login () {
    window.location.assign('/login');
}

coor = "";
until ="";
function geocode () {
    $('#valid_city_ok').text('');
    $('#valid_city').css('display', 'block');
    string = $('#city').val();
    text = string.replace(" ","+");
    $.post('geo', {query : text}, function (r) {
        if(r.status == "ZERO_RESULTS") {
            $('#valid_city').css('display', 'none');
            $('#valid_city_ok').text('Not valid!');
           
        } else {
            $('#valid_city').css('display', 'none');
            $('#valid_city_ok').text('Valid!');
            lat = r.results[0].geometry.location.lat;
            lng = r.results[0].geometry.location.lng;
            coor = lat+","+lng+",5km";
        }
       
    }, 'JSON');
}

function query () {
    
    query = $('#query').val();
    if(query != ""&&query!=" ") {
    $('#pacman').css('display', 'block');
    lang = $('#lang').find(":selected").attr('data-lang');
    type = $('#result_type').find(":selected").attr('data-type');
    until = $('#until').val();
    $.post('query', {query: query, lang:lang, type:type, until:until, coor:coor}, function (r) {
        
        tab = eval(r);
        $('#contact-area').html('');
        $.each(tab, function (key,value) {
            $("<blockquote class='twitter-tweet'><a href='"+value+"'></a></blockquote>").appendTo('#contact-area');
            $("<span>URL du Tweet: <a href='"+value+"' target='_BLANK'>"+value+"</a></span><br>").appendTo('#contact-area');
        });
        
        script = document.createElement('script');
        script.setAttribute('src', '//platform.twitter.com/widgets.js');
        document.body.appendChild(script);
        $('#pacman').css('display', 'none');
    });
    }
    else {
        alert('recherche vide'); 
    }
}

/*twitter   
window.twttr = (function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0],
    t = window.twttr || {};
  if (d.getElementById(id)) return t;
  js = d.createElement(s);
  js.id = id;
  js.src = "https://platform.twitter.com/widgets.js";
  fjs.parentNode.insertBefore(js, fjs);
 
  t._e = [];
  t.ready = function(f) {
    t._e.push(f);
  };
 
  return t;
}(document, "script", "twitter-wjs"));

function embed_tweet (id) {

    div = document.createElement('div');
    div.setAttribute('data_tweet', id);
    content = document.getElementsByTagName('content');
    
    content[0].appendChild(div);
    //element = document.querySelectorAll('[data_tweet="'+id+'"]');
    //console.log(element);
    
        twttr.widgets.createTweet(
            id.toString(),
            div,
            {
                //Theme des tweets
            }
        );


}
*/


// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
