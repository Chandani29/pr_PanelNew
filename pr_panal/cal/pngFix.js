function fixPngTransparency(obj){
	if(document.body.filters){
		pattern=/.png/gi;
		filterFix="progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+obj.src+"',sizingMethod='scale');";
		if(obj.src.search(pattern)!=-1){
			obj.style.width=obj.offsetWidth+"px";
			obj.style.height=obj.offsetHeight+"px";
			obj.style.filter=filterFix;
			obj.src="images/blank.gif";
		}
	}
}
function fixImages(){
        imageCollection=document.body.getElementsByTagName("IMG");
        for(i=0; i<imageCollection.length; i++){
               fixPngTransparency(imageCollection[i]);
        }
}