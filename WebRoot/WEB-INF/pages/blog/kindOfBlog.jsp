﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@include file="../common/taglib.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta name="Keywords" content="${blog.NAME},乐诗,krrymusic,音乐博客,博客,musicblog,音乐分享,音乐分类,音乐专题,摇滚,流行,中国风,怀旧,轻音乐,传奇,音乐互动,博文心情,言论自由">
		<meta name="Description" content="乐诗博客是一个音乐、日记分享平台，我们致力于让用户发表自己的心情，分享自己喜爱的音乐，聆听你我的声音">
		<title>${blog.NAME}</title>
		<link rel="stylesheet" href="${basePath}/resource/css/style.css" />
		<link rel="stylesheet" href="${basePath}/resource/font/iconfont.css" />
		<link type="text/css" rel="stylesheet" href="${basePath}/resource/sg/css/sg.css" />
		<link rel="stylesheet" href="${basePath}/resource/css/animate.css"/>
		<link rel="stylesheet" href="${basePath}/resource/css/krry_animateLoading.js.css"/>
		<link rel="stylesheet" href="${basePath}/resource/css/krry_returnTop.css"/>
		
		<script type="text/javascript" src="${basePath}/resource/js/jquery-1.11.2.min.js" ></script>
		<script type="text/javascript" src="${basePath}/resource/js/krry_util.js"></script>
		<script type="text/javascript" src="${basePath}/resource/js/krry_animateLoading.js"></script>
		<script type="text/javascript" src="${basePath}/resource/js/krry_admin.js"></script>
		<script type="text/javascript" src="${basePath}/resource/sg/tz_util.js"></script>
		<script type="text/javascript" src="${basePath}/resource/sg/sg.js"></script>
		<script type="text/javascript">var basePath="${basePath}";</script>
		<style>
			.hideAdd{height: 264px;
				    text-align: center;
				    line-height: 257px;
				   display:none;}
			.hideAdd .aljie{line-height:300px;font-size:22px;-webkit-text-fill-color:transparent;background: -webkit-gradient(linear,left top,left bottom,from(#FD0051),to(#A22C93));-webkit-background-clip: text;}
			.titlett{font-size: 30px;  margin-left: 132px;height: 100px;line-height: 50px;-webkit-text-fill-color:transparent;background: -webkit-gradient(linear,left top,left bottom,from(#FD0051),to(#A22C93));-webkit-background-clip: text;}
			.wrapbox .box_desc{font-size: 14px;color:#888;}
			.wrapbox .box_desc span{color:#dd5862;}
			.outlineuner{width: 100%;
					    height: 8px;
					    border-bottom: 1px solid #ddd;}
			.hotthem{color:#dd5862;}
		</style>
	</head>
	<body data-typeid="${blog.ID}">
		<%@include file="../common/header.jsp" %>
		<!-- 内容区 -->
		<div class="wrapbox">
			<div class="container">
				<a href="${basePath}" class="backnetwork"><span class="icon_backont">&lt;</span><span class="nextword">返回首页</span></a><br>
				<a href="${basePath}/blog/kindOfBlog/${blog.ID}" class="titlett">${blog.NAME}</a>
				<p class="box_desc">共有 <span></span> 个博客</p>
				<div class="all_v_ttmore">
			 		<a href="${basePath}/blog/kindOfBlog/1">摇滚</a>
			 		<a href="${basePath}/blog/kindOfBlog/2">流行</a>
			 		<a href="${basePath}/blog/kindOfBlog/3">中国风</a>
			 		<a href="${basePath}/blog/kindOfBlog/4">轻音乐</a>
			 		<a href="${basePath}/blog/kindOfBlog/5">怀旧</a>
			 		<a href="${basePath}/blog/kindOfBlog/6">传奇</a>
			 		<a href="${basePath}/blog/AllBlog">更多></a>
		 			<div class="clear"></div>
		 		</div>
				<p class="outlineuner"></p>
				<div class="hideAdd animated rotateIn">
					<a href="javascript:void(0);" class="aljie">专题《${blog.NAME}》还没有音乐博客，快快点我吧~~</a>
				</div>
				 <div class="w_left_others" style="float:none;margin:0 auto;">
				 	<!-- 内容区域 -->
				 	<div class="cntbox">
				 		<ul id="databox">
				 		</ul>
					 	<div class="loadmore">下拉加载更多博客...</div>
				 	</div>
				 </div>
				 <div class="clearfix"></div>
			</div>
		</div>
		<div class="clearfix"></div>
		<!-- end 内容区 -->
		<!--底部-->
		<%@include file="../common/footer.jsp" %>
		<script type="text/javascript">
		var krryKindBlog = {
			coutBlog:0,
			pageNo:0,
			pageSize:10,
			nowTime:0,
			mark:true,
			timer:null,
			loadWind:function(){
				var closeee = false;
				//当滚动条到达距离底部180px时
				$(window).scroll(function(){
					if(!closeee){
						closeee = true;
						return;
					}
					clearTimeout(krryKindBlog.timer);
					//可视高度
		            var cheight = $(window).height();
		            // 滚动条高度
		            var ctop = $(document).scrollTop();

		           //文档的高度
		           	if(cheight+ctop+320 > document.body.scrollHeight && krryKindBlog.mark){
		           		krryKindBlog.timer = setTimeout(function(){
		           			loadingmore($(".loadmore"));
		           			krryKindBlog.loadData();
		           		},200);
		           		
		           }
				});
			},
			loadData:function(){
				krryKindBlog.pageNo++;
				this.load();
			},
			load:function(){
				if(new Date() - krryKindBlog.nowTime > 200){
					krryKindBlog.nowTime = new Date();
					if(!krryKindBlog.mark)return;
					var typeId = $("body").data("typeid");
					var pno = krryKindBlog.pageNo * krryKindBlog.pageSize; 
		 			var psize = krryKindBlog.pageSize*(krryKindBlog.pageNo+1);
		 			var params = {
		 				typeId:typeId,
		 				pageNo:pno,
		 				pageSize:psize
		 			};
					$.ajax({
						type:"post",
						url:basePath+"/blog/loadDataAllKind",
						data:params,
						success:function(data){
							if(data){
								krryKindBlog.coutBlog += 10;
								var dataArr = data.blogs;//从map集合中拿出博客
								var len = dataArr.length;
								var countBlogs = data.coutBlogs;//总数量
								//设置数量
								$(".wrapbox .box_desc").find("span").text(countBlogs);
								
								if(countBlogs > 10){
									$(".loadmore").show();
								}
								if(countBlogs == 0){
									$(".hideAdd").show();
									$(".clearfix").css("height","0");
								}
								
								var html = "";
								for(var i = 0;i < len;i++){
									var datajson = dataArr[i];
									var desc = datajson.DESCRIPTION;
									if(desc.length>68)desc = desc.substring(0,68)+"...";
									html += "<li class='items'>"+
								 	"	<a href='"+basePath+"/blog/detail/"+datajson.ID+"' class='imgbox pr'>"+
								 	"		<img class='lazy' alt='"+datajson.TITLE+"' src='"+basePath+"/"+datajson.IMG+"' style='display: inline;' />"+
								 	"		<div class='iover'></div>"+
								 	"		<img class='i_playindex' src='"+basePath+"/resource/images/cover_play.png' width='40' height='40'/>"+
								 	"	</a>"+
								 	"	<div class='slbox'>"+
								 	"		<h3 class='title'><a href='"+basePath+"/blog/detail/"+datajson.ID+"'>"+datajson.TITLE+"</a></h3>"+
								 	"		<p class='info'>"+
								 	"			<span><i class='iconfont icon-time' title='创建时间'></i>"+datajson.CREATETIME+"</span>"+
								 	"			<span class='commentsCenter'><i class='iconfont icon-pinglun' title='评论数'></i>"+datajson.COMMENTS+"</span>"+
								 	"			<span><i class='iconfont icon-dianji' title='点击数'></i>"+datajson.HITS+"</span>"+
								 	"			<span class='comentrightz'><i class='iconfont icon-zhuanti1' title='专题'></i><a class='usercateyid' href='"+basePath+"/blog/kindOfBlog/"+datajson.CATEGORYID+"'>"+datajson.NAME+"</a></span>"+
								 	"		</p>"+
									"		<p title='作者' class='usernamemusicBlog'>作者：<a class='userIdmusicBlog' href='"+basePath+"/blog/personBlog/"+datajson.USERID+"'>"+datajson.USERNAME+"</a></p>"+
								 	"		<p class='desc'>"+desc+"</p>"+
								 	"	</div>"+
								 	"</li>";
								}
								$("#databox").append(html);
								if(countBlogs <= krryKindBlog.coutBlog){
									krryKindBlog.mark = false;
									$(".loadmore").hide();
								}else{
									$(".loadmore").html("<span>下拉加载更多博客...</span>");
								}
								//document.body.scrollTop = document.body.scrollHeight;
							}else{
								krryKindBlog.mark = false;
								$(".loadmore").hide();
			 				}
							//图片损坏的处理方案
							$("img").on("error",function(){
								$(this).attr("src",basePath+"/resource/images/noimg.jpg");
							});
			 			}
			 		});
				}
			}
		};
		$(function(){
			var height = $(window).height();
			height = height - 278;
			$(".wrapbox").css("min-height",height);
			$(window).resize(function(){
				height = $(window).height();
				height = height - 278;
				$(".wrapbox").css("min-height",height);
			});
			
			$(".aljie").click(function(){
				var userName = $("#username").text();
				if(isEmpty(userName)){
					$.tzAlert({content:"请您先登录",title:"温馨提示"});
				}else{
					window.location.href=basePath+"/admin/add"; 
				}
			});
			
			krryKindBlog.loadWind();
			krryKindBlog.load();
			
			//设置当前的专题的样式
			var indext = $("body").data("typeid");
			$(".all_v_ttmore a").eq(indext-1).css({
				"color":"#dd5862",
			});
			$(".all_v_ttmore a").eq(indext-1).removeAttr("href");
			
		});
		</script>
	</body>
</html>