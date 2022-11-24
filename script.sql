create table tb_board(
	b_idx int auto_increment primary key,
    b_userid varchar(200) not null,
    b_username varchar(300) not null,
    b_title varchar(300) not null,
    b_content text not null,
    b_hit int default 0,
    b_regdate datetime default now(),
    b_like int default 0 
);
 create table tb_reply(
	re_idx int auto_increment primary key,
    re_userid varchar(300) not null,
    re_username varchar(300) not null,
    re_content varchar(2000) not null,
    re_regdate datetime default now(),
    re_boardidx int,
    foreign key (re_boardidx) references tb_board(b_idx) on update cascade on delete cascade
 );
 
create table tb_views(
	vi_idx int auto_increment primary key,
    vi_userid varchar(20) not null,
    vi_boardidx int not null,
    foreign key (vi_boardidx) references tb_board(b_idx) on update cascade on delete cascade
);
 
create table tb_like(
	li_idx int auto_increment primary key,
    li_userid varchar(300)  not null,
    li_boardidx int,
    foreign key (li_boardidx) references tb_board(b_idx) on delete cascade
);

select * from tb_like;
drop table tb_like;
drop table tb_reply;
delete from tb_board where b_idx=5 and b_userid='melon';
select b_title, b_content from tb_board where b_idx=1;
select * from tb_member;
select * from tb_board;
select * from tb_board order by b_idx desc limit 0,10;
select count(b_idx) as cnt from tb_board;
select * from tb_reply;
select count(*) from tb_reply where re_boardidx=4;
insert into tb_board(b_userid, b_username, b_title, b_content) values('melon','김멜론','ㅇㅇㅇ','ㅇㄻㄴㄻㄴ');
SELECT TIMESTAMPDIFF(day, '2022-11-20 16:40:44', now()) dateCnt;