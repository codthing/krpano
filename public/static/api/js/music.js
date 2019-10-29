/*var music = {
	dom//绑定的音频元素id
	timeline//绑定的进度条
	isAutoPlay //是否自动播放
	playBtn //播放按钮

};*/

function AudioControl(param){
	this.param = param;
	if(this.param.isAutoPlay == "" ||this.param.isAutoPlay == undefined){
		this.param.isAutoPlay = false;
	}
	this.audio;
	this.forward = function(num){
		this.audio.currentTime = this.audio.currentTime +num;
	};
	this.backOff = function(num){
		this.audio.currentTime = this.audio.currentTime -num;
	};
	this.ready = function(){
		var audio = document.getElementById(param.dom);//获取 audio
		var p =this.param;//获取初始化时的参数
		var timeline = p.timeline;
		var setTimeShow = this.setTimeShow;
		var e = this;

		audio.addEventListener("onended", function () {  
			$(p.playBtn).removeClass('play');
		    if(p.onend != undefined){
				p.onend();
			}
    	});
		audio.addEventListener("play", function () {   //开始播放时触发
			console.log('播放');
        	$(p.playBtn).addClass('play');
			if(p.onPlay != undefined){
				p.onPlay();
			}
    	});
    	audio.addEventListener("pause", function () {   //开始播放时触发
        	$(p.playBtn).removeClass('play');
        	if(p.onPause != undefined){
				p.onPause();
			}
    	});
		this.audio = audio;
		$(audio).on('loadedmetadata', function() {//加载完成时

			// 进度条控制
			$(document).on('touchend',timeline, function(e) {
				console.log("点击");
				var x = e.originalEvent.changedTouches[0].clientX - this.offsetLeft;
				var X = x < 0 ? 0 : x;
				var W = $(this).width();
				var place = X > W ? W : X;
				audio.currentTime = (place / W).toFixed(2) * audio.duration
				$(this).children().css({
					width: (place / W).toFixed(2) * 100 + "%"
				})
			});
			// 播放
			// 暂停
			if(p.playBtn){
				
				$(p.playBtn).on('click', function() {
					var has = $(this).hasClass('play');
					if(has == true){
						audio.pause();
					}else{
						audio.play();
					}
				});
			}
			var currentTime = audio.currentTime;
			setTimeShow(currentTime);
			setInterval(function() {
				currentTime = audio.currentTime;
				setTimeShow(currentTime);
			}, 1000);
			if(p.isAutoPlay == false){//是否自动播放
				audio.pause();
			}else{
				audio.play();
			}
			
			// 设置播放时间
			function setTimeShow(t) {
				t = Math.floor(t);
				var playTime = secondToMin(audio.currentTime);
				$(".size").html(playTime);
				$('.timeshow').text(secondToMin(audio.duration));				$(timeline).find("span").css({
					width: (t / audio.duration).toFixed(4) * 100 + "%"
				})
			}
			// 计算时间
			function secondToMin(s) {
				var MM = Math.floor(s / 60);
				var SS = s % 60;
				if (MM < 10)
					MM = "0" + MM;
				if (SS < 10)
					SS = "0" + SS;
				var min = MM + ":" + SS;
				return min.split('.')[0];
			}
		})
	}
}

// function AudioControl(id) {
// 		// 音频控制进度条
// 		var audio = document.getElementById(id);
// 		$(audio).on('loadedmetadata', function() {
// 			audio.pause();
// 			// 进度条控制
// 			$(document).on('touchend', '.timeline', function(e) {
// 				var x = e.originalEvent.changedTouches[0].clientX - this.offsetLeft;
// 				var X = x < 0 ? 0 : x;
// 				var W = $(this).width();
// 				var place = X > W ? W : X;
// 				audio.currentTime = (place / W).toFixed(2) * audio.duration
// 				$(this).children().css({
// 					width: (place / W).toFixed(2) * 100 + "%"
// 				})
// 			});
// 			// 播放
// 			$("#js-play").on('click', function() {
// 				$(this).hide();
// 				$('#js-pause').show();
// 				audio.play()
// 			});
// 			// 暂停
// 			$('#js-pause').on('click', function() {
// 				$(this).hide();
// 				$('#js-play').show();
// 				audio.pause()
// 			});
// 			$('#kj').on('click', function() {
// 				audio.currentTime = audio.currentTime +15;
// 			});
// 			$('#ht').on('click', function() {
			
// 			});
// 		})
// 		setInterval(function() {
// 			var currentTime = audio.currentTime;
// 			setTimeShow(currentTime);
// 		}, 1000);
// 		// 设置播放时间
// 		function setTimeShow(t) {
// 			t = Math.floor(t);
// 			var playTime = secondToMin(audio.currentTime);
// 			$(".size").html(playTime);
// 			$('.timeshow').text(secondToMin(audio.duration))
// 			$('.timeline').children().css({
// 				width: (t / audio.duration).toFixed(4) * 100 + "%"
// 			})
// 		}
// 		// 计算时间
// 		function secondToMin(s) {
// 			var MM = Math.floor(s / 60);
// 			var SS = s % 60;
// 			if (MM < 10)
// 				MM = "0" + MM;
// 			if (SS < 10)
// 				SS = "0" + SS;
// 			var min = MM + ":" + SS;
// 			return min.split('.')[0];
// 		}
// 	}