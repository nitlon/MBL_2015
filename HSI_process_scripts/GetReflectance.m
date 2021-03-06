function GetReflectance(Date, ObjectDirectory, WhiteDirectory)

WaveNumber = ['360nm', '380nm', '405nm', '420nm', '436nm', '460nm', '480nm', '500nm', '520nm', '540nm', '560nm', '580nm', '600nm', '620nm', '640nm', '660nm'];

for i = 1:16
    ObjectFilename = [Date,'/',ObjectDirectory,'/',ObjectDirectory,'_',WaveNumber((i-1)*5+1:i*5),'_raw.tiff'];  
    ObjectImg(:,:,i) = imread(ObjectFilename,'tiff');
    WhiteFilename = [Date,'/',WhiteDirectory,'/',WhiteDirectory,'_',WaveNumber((i-1)*5+1:i*5),'_raw.tiff'];  
    WhiteImg(:,:,i) = imread(WhiteFilename,'tiff');
end

UpBound = max(max(WhiteImg(:,:,10)));
sc = 2^16/UpBound;
ScaledImg = WhiteImg*sc;

figure
imshow(ScaledImg(:,:,10));

rect = getrect;

for i = 1:16
    AvgWhite = mean2(WhiteImg(540-round(rect(2))-round(rect(4)):540-round(rect(2)),round(rect(1)):round(rect(1))+round(rect(3)),i));
    RefObjectImg(:,:,i) = ObjectImg(:,:,i)/AvgWhite;
end

ImgRGB(:,:,1) = RefObjectImg(:,:,15); % 640nm
ImgRGB(:,:,2) = RefObjectImg(:,:,10); % 540nm
ImgRGB(:,:,3) = RefObjectImg(:,:,5);  % 436nm

UpBound = max(ImgRGB(:));
sc = 2^16/UpBound;
ScaledImgRGB = ImgRGB*sc;

figure
imshow(ScaledImgRGB);
end