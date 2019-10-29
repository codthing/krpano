
var mySwiper2,mySwiper3;
//浏览器窗口大小变化时
$(window).resize(function() {

    var window_width = $(window).width();//获取浏览器窗口宽度
    if(window_width<=768){

        window['adaptive'].desinWidth = 750;//设计稿宽度
        window['adaptive'].baseFont = 28;//默认字体大小
        window['adaptive'].maxWidth = 750;//最大宽度
        window['adaptive'].init();


    }else {

        window['adaptive'].desinWidth = 1440;//设计稿宽度
        window['adaptive'].baseFont = 14;//默认字体大小
        window['adaptive'].maxWidth = 1440;//最大宽度
        window['adaptive'].init();

    }

    $(".main-view").css({
        minHeight: $(window).height()-$(".header-view").outerHeight(true)-$(".footer-view").outerHeight(true)
    })
});

$(function () {


    //页面加载执行
    var window_width = $(window).width();//获取浏览器窗口宽度
    if(window_width<=768){
        // 成功案例轮播
        mySwiper2 = new Swiper('.case-scroll',{
            autoplay: 3000,
            effect : 'slide',
            slidesPerView: 1,
            spaceBetween: 0,
            speed: 1000,
            prevButton:'.case-view-list .swiper-button-prev',
            nextButton:'.case-view-list .swiper-button-next',
            pagination: '.swiper-pagination',
            paginationClickable :true,
        });
        // 荣誉资质
        mySwiper3 = new Swiper('.honor',{
            effect : 'slide',
            slidesPerView: 2,
            spaceBetween: 20,
            speed: 1000,
            prevButton:'.honor-list .swiper-button-prev',
            nextButton:'.honor-list .swiper-button-next',
        });
    }else {

        // 成功案例轮播
        mySwiper2 = new Swiper('.case-scroll',{
            autoplay: 3000,
            effect : 'slide',
            slidesPerView: 3,
            spaceBetween: 46,
            speed: 1000,
            pagination: '.case-view-list .swiper-pagination',
            prevButton:'.case-view-list .swiper-button-prev',
            nextButton:'.case-view-list .swiper-button-next',
            paginationClickable :true,
        });
        // 荣誉资质
        mySwiper3 = new Swiper('.honor',{
            autoplay: 3500,
            effect : 'slide',
            slidesPerView: 4,
            spaceBetween: 40,
            speed: 1000,
            prevButton:'.honor-list .swiper-button-prev',
            nextButton:'.honor-list .swiper-button-next',
        });

    }

    // 历程 事件
    var mySwiper5 = new Swiper('.event',{
        effect : 'slide',
        slidesPerView: 1,
        spaceBetween: 20,
        speed: 1000,
        prevButton:'.event .swiper-button-prev',
        nextButton:'.event .swiper-button-next',
        simulateTouch : false

    });
    // 历程 年份
    var mySwiper6 = new Swiper('.years-list',{
        slidesPerView: 5,
        spaceBetween: 0,
        speed: 1000,
        slideToClickedSlide:true,
        centeredSlides : true

    });
    mySwiper5.params.control = mySwiper6;//需要在Swiper2初始化后，Swiper1控制Swiper2
    mySwiper6.params.control = mySwiper5;//需要在Swiper1初始化后，Swiper2控制Swiper1
    var Swiper7 = new Swiper('#swiper-container3',{
        control: [mySwiper5, mySwiper6],//控制前面两个Swiper
    });

    // 视频展示
    var mySwiper4 = new Swiper('.video-scroll',{
        effect : 'slide',
        slidesPerView: 5,
        slidesPerGroup: 5,
        spaceBetween: 20,
        direction : 'vertical',
        speed: 1000,
        prevButton:'.video-page .swiper-button-prev',
        nextButton:'.video-page .swiper-button-next',
    });




    //初始化动画效果
	new WOW().init();
	
	// 图片懒加载
	$("img.lazy").lazyload({effect: "fadeIn"});
	// layui.use('flow', function(){
	//   var flow = layui.flow;
	//   //当你执行这样一个方法时，即对页面中的全部带有lay-src的img元素开启了懒加载（当然你也可以指定相关img）
	//   flow.lazyimg(); 
	// });


	// 首页轮播
	var mySwiper1 = new Swiper('.banner-scroll',{
	    autoplay: 4000,
	    effect : 'slide',
		loop: true,
	    slidesPerView: 1,
	    speed: 1000,
        pagination : '.swiper-pagination',
        paginationClickable :true,
	});

    //加载动画

    //首页
    $(".kinds-ul ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.1*e+"s")
    });

    $(".field-view-list ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.1*e+"s")
    });

    $(".case-view-list ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInUpBig");
        $(this).attr("data-wow-delay",0.1*e+"s")
    });

    $(".news-list ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.1*e+"s")
    });

    $(".pc-div ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.08*e+"s")
    });
    $(".wap-div ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInUpBig");
        $(this).attr("data-wow-delay",0.08*e+"s")
    });
    //首页 end

    //内页
    $(".main-nav ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInLeftBig");
        $(this).attr("data-wow-delay",0.08*e+"s")
    });
    $(".download-list ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.08*e+"s")
    });
    $(".pages a").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.08*e+"s")
    });
    $(".case-list ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.08*e+"s")
    });
    $(".news ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.08*e+"s")
    });
    $(".life-list ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.08*e+"s")
    });
    $(".honor ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.08*e+"s")
    });

    $(".video-scroll ul li").each(function (e) {
        e = $(this).index();
        $(this).addClass("wow fadeInRightBig");
        $(this).attr("data-wow-delay",0.08*e+"s")
    });

    //内页 end




});

