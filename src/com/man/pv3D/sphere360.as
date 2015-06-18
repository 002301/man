package src.com.man.pv3D
{

	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.MovieClip;

	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.materials.utils.BitmapMaterialTools;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.materials.special.CompositeMaterial;
	import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.objects.primitives.Sphere;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.render.BasicRenderEngine;



	public class sphere360Example extends MovieClip
	{

		private var scene:Scene3D;
		private var viewport:Viewport3D;
		private var camera:Camera3D;
		private var renderEngine:BasicRenderEngine;
		private var cube:Cube;
		private var sphere:Sphere;

		public var moveID:Number = 0;
		public var moveIDX:Number = 0;

		public function sphere360Example()
		{
			init();
		}
		private function init():void
		{
			scene= new Scene3D();
			//创建一个无参的Scene3D实例
			camera=new Camera3D();
			//摄像机在创建时可以设定参数
			//加入到场景里
			viewport = new Viewport3D(1280,700,false,true);
			viewport.containerSprite.tabEnabled = false;
			viewport.containerSprite.buttonMode = true;
			MC.addChild(viewport);
			//加入到舞台上让其可见

			var material:BitmapFileMaterial = new BitmapFileMaterial("pic/zhongjing.jpg",true);
			material.addEventListener(FileLoadEvent.LOAD_COMPLETE,loadComplete);
			

			sphere = new Sphere(material,960,50,50);
			scene.addChild(sphere);
			camera.z = 40;
			camera.zoom = 40;
			camera.fov = 40;
			
		}
		private function loadComplete(e:FileLoadEvent):void
		{
			var material:BitmapFileMaterial = BitmapFileMaterial(e.target);
			material.doubleSided = true;
			material.opposite = true;
			material.smooth = true;
			BitmapMaterialTools.mirrorBitmapX(material.bitmap);
			renderEngine=new BasicRenderEngine();
			renderEngine.renderScene(scene,camera,viewport);
			this.addEventListener(Event.ENTER_FRAME,enters);

		}
		public function rotationsMoveY():void
		{

			sphere.localRotationY +=  (sphere.localRotationY-(sphere.localRotationY+moveID))*0.05;
			camera.localRotationX +=   -  (camera.localRotationX-(camera.localRotationX+moveIDX))*0.05;
			camera.localRotationX = fix(camera.localRotationX);
		
		}
		private function fix(arg:Number)
		{
			if (-90 > arg)
			{
				arg = -90;
			}
			if (arg > 90)
			{
				arg = 90;
			}
			return arg;
		}
		public function enters(e:Event)
		{
			renderEngine.renderScene(scene,camera,viewport);
		}
	}

}