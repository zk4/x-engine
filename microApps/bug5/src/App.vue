<template>
	<div id="app">
		<router-view/>
	</div>
</template>

<style>
*{
	box-sizing: border-box;
}
#app {
	font-family: Avenir, Helvetica, Arial, sans-serif;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
	font-size: .24rem;
	box-sizing: border-box;
}
/*增加底部适配层*/
@media (device-width : 375px) and (min-device-height : 812px) , (device-width : 414px) and (min-device-height : 896px){
	#app{padding-bottom: 34px;}
}
</style>
