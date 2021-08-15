/datum/minimap
	var/name = "minimap"
	var/icon/overlay_icon
	// The map icons
	var/icon/map_icon
	var/icon/meta_icon

	var/list/color_area_names = list()

	var/minx
	var/maxx
	var/miny
	var/maxy

	var/z_level
	var/id = ""

/datum/minimap/New(z, x1 = 1, y1 = 1, x2 = world.maxx, y2 = world.maxy, name = "minimap")
	if(!z)
		CRASH("ERROR: new minimap requested without z level") //CRASH to halt the operatio

	src.name = name
	z_level = z
	id = "[md5("[z_level]" + src.name + REF(src))]" //use it's own md5 as a special identifier

	var/crop_x1 = x2
	var/crop_x2 = x1
	var/crop_y1 = y2
	var/crop_y2 = y1

	// do the generating
	map_icon = new('html/blank.png')
	meta_icon = new('html/blank.png')
	map_icon.Scale(x2 - x1 + 1, y2 - y1 + 1) // arrays start at 1
	meta_icon.Scale(x2 - x1 + 1, y2 - y1 + 1)

	var/list/area_to_color = list()
	for(var/turf/T in block(locate(x1, y1, z_level), locate(x2, y2, z_level)))
		var/area/A = T.loc
		var/img_x = T.x - x1 + 1 // arrays start at 1
		var/img_y = T.y - y1 + 1
		if(!istype(A, /area/space) || istype(T, /turf/closed/wall))
			crop_x1 = min(crop_x1, T.x)
			crop_x2 = max(crop_x2, T.x)
			crop_y1 = min(crop_y1, T.y)
			crop_y2 = max(crop_y2, T.y)

		var/meta_color = area_to_color[A]
		if(!meta_color)
			meta_color = rgb(rand(0, 255), rand(0, 255), rand(0, 255)) // technically conflicts could happen but it's like very unlikely and it's not that big of a deal if one happens
			area_to_color[A] = meta_color
			color_area_names[meta_color] = A.name
		meta_icon.DrawBox(meta_color, img_x, img_y)

		if(istype(T, /turf/closed/wall))
			map_icon.DrawBox("#000000", img_x, img_y)

		else if(!istype(A, /area/space))
			var/color = A.minimap_color || "#FF00FF"
			if(locate(/obj/machinery/power/solar) in T)
				color = "#02026a"

			if((locate(/obj/effect/spawner/structure/window) in T) || (locate(/obj/structure/grille) in T))
				color = BlendRGB(color, "#000000", 0.5)
			map_icon.DrawBox(color, img_x, img_y)

	map_icon.Crop(crop_x1, crop_y1, crop_x2, crop_y2)
	meta_icon.Crop(crop_x1, crop_y1, crop_x2, crop_y2)
	minx = crop_x1
	maxx = crop_x2
	miny = crop_y1
	maxy = crop_y2
	overlay_icon = new(map_icon)
	overlay_icon.Scale(16, 16)
	//we're done baking, now we ship it.
	if (!SSassets.cache["minimap-[id].png"])
		SSassets.transport.register_asset("minimap-[id].png", map_icon)
	if (!SSassets.cache["minimap-[id]-meta.png"])
		SSassets.transport.register_asset("minimap-[id]-meta.png", meta_icon)

/datum/minimap/proc/send(mob/user)
	if(!id)
		CRASH("ERROR: send called, but the minimap id is null/missing. ID: [id]")
	SSassets.transport.send_assets(user.client, list("minimap-[id].png" = map_icon, "minimap-[id]-meta.png" = meta_icon))

/datum/minimap_group
	var/list/minimaps = list()
	var/static/next_id = 0
	var/id
	var/name

/datum/minimap_group/New(list/maps, name)
	id = ++next_id
	src.name = name
	if(maps)
		minimaps = maps

/datum/minimap_group/proc/show(mob/user)
	if(!length(minimaps))
		to_chat(user, "<span class='boldwarning'>ERROR: Attempted to access an empty datum/minimap_group. This should probably not happen.</span>")
		return

	var/list/datas = list()
	var/list/info = list()

	for(var/i in 1 to length(minimaps))// OLD: for(var/i in 1 to length(minimaps))
		var/datum/minimap/M = minimaps[i]
		var/map_name = "minimap-[M.id].png"
		var/meta_name = "minimap-[M.id]-meta.png"
		M.send(user)
		info += {"
			<div class="block">
				<div> <!-- The div is in here to fit it both in the block div -->
					<img id='map-[i]' src='[SSassets.transport.get_asset_url(map_name)]' />
					<img id='map-[i]-meta' src='[SSassets.transport.get_asset_url(meta_name)]' style='display: none' />
				</div>
				<div class="statusDisplay" id='label-[i]'></div>
			</div>
		"}
		datas += json_encode(M.color_area_names);

	info = info.Join()
	//this is bad. Too bad!
	var/headerJS = {"
	<script>
		function hexify(num) {
			if(!num){
				num = 0;
			}
			num = num.toString(16);
			if(num.length == 1){
				num = "0" + num;
			}
			return num;
		}
		window.onload = function() {
			if(!window.HTMLCanvasElement) {
				var label = document.getElementById("label-1");
				label.textContent = "<h1>WARNING! HTMLCanvasElement not found!</h1>"
				return false
			}
			var datas = \[[jointext(datas, ",")]]
			for(var i = 0; i < [length(minimaps)]; i++) {
				//the fuck is this wrapped?
				var data = datas\[i];
				var img = document.getElementById("map-" + (i + 1));
				if(!img){
					return; //if it does not exist, it means it's done!
				}
				var canvas = document.createElement("canvas");
				canvas.width = img.width * 2;
				canvas.height = img.height * 2;

				var ctx = canvas.getContext('2d');
				ctx.msImageSmoothingEnabled = false;
				ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
				img.parentNode.replaceChild(canvas, img);
				ctx = document.createElement("canvas").getContext('2d');
				ctx.canvas.width = img.width;
				ctx.canvas.height = img.height;
				ctx.drawImage(document.getElementById("map-" + (i+1) + "-meta"), 0, 0);

				var imagedata = ctx.getImageData(0, 0, img.width, img.height);

				canvas.onmousemove = function(e){
					var rect = canvas.getBoundingClientRect();
					var x = Math.floor(e.offsetX * img.width / rect.width);
					var y = Math.floor(e.offsetY * img.height / rect.height);

					var color_idx = x * 4 + (y * 4 * imagedata.width);
					var color = "#" + hexify(imagedata.data\[color_idx]) + hexify(imagedata.data\[color_idx+1]) + hexify(imagedata.data\[color_idx+2]);
					var label = document.getElementById("label-" + (i+1)); //label-String(n)

					label.textContent = data\[color];
					canvas.title = data\[color];
				}
				canvas.onmouseout = function(e){
					canvas.title = "";
				}
			}
		}
	</script>
	<style>
		img, canvas {
			width: 100%;
			background-color: white;
		}
	</style>
	"}

	var/datum/browser/popup = new(user, "minimap_[id]", name, 500, 700)
	popup.add_head_content(headerJS) //set the head
	popup.set_content(info)
	popup.open(FALSE)
