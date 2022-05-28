function fig_maker(search_type,N)
    switch(search_type) 
        case 'feature no target'
            clf()
            Xy = randperm(85,2*N)/90;
            location =reshape(Xy,2,N);
            xrp = location(1 ,:);
            yrp = location(2 ,:);
            XO =["X","O"];
            Color = ["blue","red"];
            axis off;
            text(xrp,yrp,randsample(XO,1),'color',randsample(Color,1));
        case 'feature with target'
            clf()
            Xy = randperm(85,2*N)/90;
            location =reshape(Xy,2,N);
            xrp = location(1 ,:);
            yrp = location(2 ,:);
            XO =["X","O"];
            Color = ["blue","red"];
            axis off;
            rnd_c = randsample(Color,2);
            rnd_xo =randsample(XO,2);
            text(xrp(1),yrp(1),rnd_xo(1),'color',rnd_c(1)); %target
            text(xrp(2:N),yrp(2:N),rnd_xo(2),'color',rnd_c(2));
           
        case 'conjunction no target'
            clf()
            Xy = randperm(85,2*N)/90;
            location =reshape(Xy,2,N);
            xrp = location(1 ,:);
            yrp = location(2 ,:);
            XO =["X","O"];
            Color = ["blue","red"];
            axis off;
            rnd_c = randsample(Color,2);
            rnd_xo =randsample(XO,2);
            text(xrp(1:N/2),yrp(1:N/2),rnd_xo(1),'color',rnd_c(1));
            text(xrp((N/2)+1:N),yrp((N/2)+1:N),rnd_xo(2),'color',rnd_c(2));
              
    
        case 'conjunction with target'
            clf()
            Xy = randperm(80,2*N)/90;
            location =reshape(Xy,2,N);
            xrp = location(1 ,:);
            yrp = location(2 ,:);
            XO =["X","O"];
            Color = ["blue","red"];
            axis off;
            rnd_c = randsample(Color,2);
            rnd_xo =randsample(XO,2);
            text(xrp(1:N/2),yrp(1:N/2),rnd_xo(1),'color',rnd_c(1));
            text(xrp((N/2)+1:N-1),yrp((N/2)+1:N-1),rnd_xo(2),'color',rnd_c(2));
            text(xrp(N),yrp(N),rnd_xo(2),'color',rnd_c(1)); 
    end
end