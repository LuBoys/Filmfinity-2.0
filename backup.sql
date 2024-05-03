--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: app
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO app;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: acteur; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.acteur (
    id integer NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    nickname character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.acteur OWNER TO app;

--
-- Name: acteur_films; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.acteur_films (
    acteur_id integer NOT NULL,
    films_id integer NOT NULL
);


ALTER TABLE public.acteur_films OWNER TO app;

--
-- Name: acteur_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.acteur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.acteur_id_seq OWNER TO app;

--
-- Name: commentaire; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.commentaire (
    id integer NOT NULL,
    users_id integer,
    films_id integer,
    commentaire text,
    date_commentaire timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    moderation timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    rating integer
);


ALTER TABLE public.commentaire OWNER TO app;

--
-- Name: commentaire_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.commentaire_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commentaire_id_seq OWNER TO app;

--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO app;

--
-- Name: favorie; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.favorie (
    id integer NOT NULL,
    users_id integer,
    films_id integer
);


ALTER TABLE public.favorie OWNER TO app;

--
-- Name: favorie_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.favorie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favorie_id_seq OWNER TO app;

--
-- Name: films; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.films (
    id integer NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    description text DEFAULT NULL::character varying,
    moderation character varying(255) DEFAULT NULL::character varying,
    date_sortie date
);


ALTER TABLE public.films OWNER TO app;

--
-- Name: films_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.films_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.films_id_seq OWNER TO app;

--
-- Name: films_likes_films; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.films_likes_films (
    films_id integer NOT NULL,
    likes_films_id integer NOT NULL
);


ALTER TABLE public.films_likes_films OWNER TO app;

--
-- Name: genre; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.genre (
    id integer NOT NULL,
    name character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.genre OWNER TO app;

--
-- Name: genre_films; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.genre_films (
    genre_id integer NOT NULL,
    films_id integer NOT NULL
);


ALTER TABLE public.genre_films OWNER TO app;

--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genre_id_seq OWNER TO app;

--
-- Name: image; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.image (
    id integer NOT NULL,
    imagefilm_id integer,
    titre character varying(255) DEFAULT NULL::character varying,
    photo character varying(255) DEFAULT NULL::character varying,
    path character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.image OWNER TO app;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.image_id_seq OWNER TO app;

--
-- Name: likes_films; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.likes_films (
    id integer NOT NULL,
    likes_films date,
    film_id integer,
    user_id integer,
    rating integer
);


ALTER TABLE public.likes_films OWNER TO app;

--
-- Name: likes_films_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.likes_films_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.likes_films_id_seq OWNER TO app;

--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.messenger_messages (
    id bigint NOT NULL,
    body text NOT NULL,
    headers text NOT NULL,
    queue_name character varying(190) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    available_at timestamp(0) without time zone NOT NULL,
    delivered_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.messenger_messages OWNER TO app;

--
-- Name: COLUMN messenger_messages.created_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.messenger_messages.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.available_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.messenger_messages.available_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.delivered_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.messenger_messages.delivered_at IS '(DC2Type:datetime_immutable)';


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messenger_messages_id_seq OWNER TO app;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.notes (
    id integer NOT NULL,
    films_id integer,
    date timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    note double precision
);


ALTER TABLE public.notes OWNER TO app;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notes_id_seq OWNER TO app;

--
-- Name: producteur; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.producteur (
    id integer NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    nickname character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.producteur OWNER TO app;

--
-- Name: producteur_films; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.producteur_films (
    producteur_id integer NOT NULL,
    films_id integer NOT NULL
);


ALTER TABLE public.producteur_films OWNER TO app;

--
-- Name: producteur_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.producteur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producteur_id_seq OWNER TO app;

--
-- Name: realisateur; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.realisateur (
    id integer NOT NULL,
    name character varying(255) DEFAULT NULL::character varying,
    nickname character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.realisateur OWNER TO app;

--
-- Name: realisateur_films; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.realisateur_films (
    realisateur_id integer NOT NULL,
    films_id integer NOT NULL
);


ALTER TABLE public.realisateur_films OWNER TO app;

--
-- Name: realisateur_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.realisateur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.realisateur_id_seq OWNER TO app;

--
-- Name: reset_password_request; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.reset_password_request (
    id integer NOT NULL,
    user_id integer NOT NULL,
    selector character varying(20) NOT NULL,
    hashed_token character varying(100) NOT NULL,
    requested_at timestamp(0) without time zone NOT NULL,
    expires_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.reset_password_request OWNER TO app;

--
-- Name: COLUMN reset_password_request.requested_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.reset_password_request.requested_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN reset_password_request.expires_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.reset_password_request.expires_at IS '(DC2Type:datetime_immutable)';


--
-- Name: reset_password_request_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.reset_password_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reset_password_request_id_seq OWNER TO app;

--
-- Name: users; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.users (
    id integer NOT NULL,
    notes_id integer,
    email character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    nickname character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO app;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO app;

--
-- Name: users_likes_films; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.users_likes_films (
    users_id integer NOT NULL,
    likes_films_id integer NOT NULL
);


ALTER TABLE public.users_likes_films OWNER TO app;

--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: acteur; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.acteur (id, name, nickname) FROM stdin;
1	Rebecca Hall	\N
2	Brian Tyree Henry	\N
3	Dan Stevens	\N
4	Kaylee Hottle	\N
5	Alex Ferns	\N
6	Fala Chen	\N
7	Rachel House	\N
8	Ron Smyck	\N
9	Chantelle Jamieson	\N
10	Greg Hatton	\N
11	Kevin Copeland	\N
12	Tess Dobre	\N
13	Tim Carroll	\N
14	Anthony Brandon Wong	\N
15	Sophia Emberson-Bain	\N
16	Chika Ikogwe	\N
17	Vincent B. Gorce	\N
18	Yeye Zhou	\N
19	Jamaliah Othman	\N
20	Nick Lawler	\N
21	Jordy Campbell	\N
22	Cassie Riley	\N
23	Tom Arnold	\N
24	Eugenia Kuzmina	\N
25	Corbin Timbrook	\N
26	Jack Pearson	\N
27	Brendan Petrizzo	\N
28	Xander Bailey	\N
29	Lindsey Marie Wilson	\N
30	Lisa Lee	\N
31	Maureen Kedes	\N
32	Sady Diallo	\N
33	Iris Svis	\N
34	Elizabeth Harding	\N
35	Anna Telfer	\N
36	Colm Meaney	\N
37	Phyllis Logan	\N
38	Sophie McIntosh	\N
39	Will Attenborough	\N
40	Jeremias Amoore	\N
41	Manuel Pacific	\N
42	Grace Nettle	\N
43	James Carroll Jordan	\N
44	David J Biscoe	\N
45	David Samartin	\N
46	Scott Coker	\N
47	Lee Byford	\N
48	Sofia Boutella	\N
49	Michiel Huisman	\N
50	Ed Skrein	\N
51	Djimon Hounsou	\N
52	Bae Doona	\N
53	Staz Nair	\N
54	Elise Duffy	\N
55	Anthony Hopkins	\N
56	Cleopatra Coleman	\N
57	Fra Fee	\N
58	Charlotte Maggi	\N
59	Sky Yang	\N
60	Stuart Martin	\N
61	Alfonso Herrera	\N
62	Cary Elwes	\N
63	Rhian Rees	\N
64	Dustin Ceithamer	\N
65	Ray Fisher	\N
66	Ingvar E. Sigurðsson	\N
67	Stella Grace Fitzgerald	\N
68	Josefine Lindegaard	\N
69	Melissa Hunt	\N
70	Sisse Marie	\N
71	Thomas Ohrstrom	\N
72	Thor Knai	\N
73	Savanna Gann	\N
74	Danielle Burgio	\N
75	Julian Grant	\N
76	Patrick Luwis	\N
77	Tomm Voss	\N
78	Christine Kellogg-Darrin	\N
79	Skylar Okerstrom-Lang	\N
80	Caden Dragomer	\N
81	Kayden Alexander Koshelev	\N
82	Kingston Foster	\N
83	Robbie Jarvis	\N
84	Ben Turner Dixon	\N
85	Mike Kopera	\N
86	Brett Robert Culbert	\N
87	Max Pescherine	\N
88	Matt Nolan	\N
89	Kevin Stidham	\N
90	Max Deacon	\N
91	Eric Barron	\N
92	Hamish Sturgeon	\N
93	Charlie Clapham	\N
94	Adam J. Smith	\N
95	Michael James Bell	\N
96	Richard Cetrone	\N
97	Darren Jacobs	\N
98	Gildart Jackson	\N
99	Soma Mitra	\N
100	Daisy Davis	\N
101	Shay Hatten	\N
102	Winfield Wallace	\N
103	Erik Thomas	\N
104	Sam Stinson	\N
105	Timothée Chalamet	\N
106	Zendaya	\N
107	Rebecca Ferguson	\N
108	Javier Bardem	\N
109	Josh Brolin	\N
110	Austin Butler	\N
111	Florence Pugh	\N
112	Dave Bautista	\N
113	Christopher Walken	\N
114	Léa Seydoux	\N
115	Stellan Skarsgård	\N
116	Charlotte Rampling	\N
117	Souheila Yacoub	\N
118	Roger Yuan	\N
119	Babs Olusanmokun	\N
120	Alison Halstead	\N
121	Giusi Merli	\N
122	Kait Tenison	\N
123	Tara Breathnach	\N
124	Akiko Hitomi	\N
125	Imola Gáspár	\N
126	Alison Adnet	\N
127	Hamza Baissa	\N
128	Hassan Najib	\N
129	Jasper Ryan-Carter	\N
130	Elbooz Omar Ahmed Fathie	\N
131	Abdelkarim Hussein Seli Mohamed Hassanin	\N
132	Joseph Beddelem	\N
133	Xavier Alba Royo	\N
134	Rachid Abbad	\N
135	Affif Ben Badra	\N
136	Botond Bóta	\N
137	Abdelaziz Boumane	\N
138	Abdellah Echahbi	\N
139	Zouhair Elakkari	\N
140	Noureddine Hajoujou	\N
141	Mohamed Mouraoui	\N
142	Adil Achraf Sayd	\N
143	Hamza Sayd	\N
144	Hopi Grace	\N
145	Havin Fathi	\N
146	Kincsö Pethö	\N
147	Cat Simmons	\N
148	Burt Caesar	\N
149	Remi Fadare	\N
150	Amer El-Erwadi	\N
151	Tedroy Newell	\N
152	Oxa Hazel	\N
153	Hajiyeva Pakiza	\N
154	Leon Herbert	\N
155	Sima Rostami	\N
156	Yvonne Campbell	\N
157	Joseph Charles	\N
158	Vic Zander	\N
159	Dylan Baldwin	\N
160	Marcia Tucker	\N
161	Nicola Brome	\N
162	Kathy Owen	\N
163	Huw Novelli	\N
164	Moe Bar-El	\N
165	Serhat Metin	\N
166	Amra Mallassi	\N
167	Adam Bloom	\N
168	Luis Alkmim	\N
169	Jordan Long	\N
170	Omar A.K.	\N
171	Zdeněk Dvořáček	\N
172	Billy Clements	\N
173	Anton Saunders	\N
174	Lex Daniel	\N
175	Dominic McHale	\N
176	Paul Boyle	\N
177	Niall White	\N
178	Tony Cook	\N
179	Gábor Szemán	\N
180	Jonathan Gunning	\N
181	Will Irvine	\N
182	Alan Mehdizadeh	\N
183	Rex Adams	\N
184	Molly Mcowan	\N
185	Ana Cilas	\N
186	Kajsa Mohammar	\N
187	Sára Bácsfalvi	\N
188	Kocsis Zsofia	\N
189	Matthew Sim	\N
190	Steve Wall	\N
191	Italo Amerighi	\N
192	Tim Hilborne	\N
193	Cecile Sinclair	\N
194	Tracy Coogan	\N
195	Zoe Kata Kaska	\N
196	Jimmy Walker	\N
197	Rand Faris	\N
198	Fouad Humaidan	\N
199	Manaf Irani	\N
200	Dora Kápolnai-Schvab	\N
201	Joelle	\N
202	Anya Taylor-Joy	\N
203	Peter Sztojanov Jr.	\N
204	Alexandra Tóth	\N
205	Jack Black	\N
206	Awkwafina	\N
207	Viola Davis	\N
208	Dustin Hoffman	\N
209	Bryan Cranston	\N
210	James Hong	\N
211	Ian McShane	\N
212	Ke Huy Quan	\N
213	Ronny Chieng	\N
214	Lori Tan Chinn	\N
215	Seth Rogen	\N
216	Jimmy Donaldson	\N
217	James Murray	\N
218	James Sie	\N
219	Cedric Yarbrough	\N
220	Vic Chao	\N
221	Audrey Brooke	\N
222	Lincoln Nakamura	\N
223	Cece Valentina	\N
224	April Hong	\N
225	Suzanne Buirgy	\N
226	Logan Kim	\N
227	Reyn Doi	\N
228	Mick Wingert	\N
229	Peggy Etra	\N
230	Gedde Watanabe	\N
231	Karen Maruyama	\N
232	Tom McGrath	\N
233	Phil LaMarr	\N
234	Mike Mitchell	\N
235	Colleen Smith	\N
236	Sarah Sarang Oh	\N
237	Paul Pape	\N
238	James Taku Leung	\N
239	Steve Alterman	\N
240	Christopher Knights	\N
241	Harry Shum Jr.	\N
242	Sydney Sweeney	\N
243	Álvaro Morte	\N
244	Benedetta Porcaroli	\N
245	Dora Romano	\N
246	Giorgio Colangeli	\N
247	Simona Tabasco	\N
248	Giampiero Judica	\N
249	Niccolò Senni	\N
250	Giulia Heathfield Di Renzi	\N
251	Giampiero Judica	\N
252	Betti Pedrazzi	\N
253	Giuseppe Lo Piccolo	\N
254	Cristina Chinaglia	\N
255	Isabel Desantis	\N
256	Viviane Florentine Nicolai	\N
257	Marisa Regina	\N
258	Laura Camassa	\N
259	Cinzia Fantauzzi	\N
260	Tiziano Ferracci	\N
261	François Civil	\N
262	Vincent Cassel	\N
263	Romain Duris	\N
264	Pio Marmaï	\N
265	Eva Green	\N
266	Lyna Khoudri	\N
267	Louis Garrel	\N
268	Vicky Krieps	\N
269	Jacob Fortune-Lloyd	\N
270	Eric Ruf	\N
271	Marc Barbé	\N
272	Patrick Mille	\N
273	Julien Frison	\N
274	Ralph Amoussou	\N
275	Alexis Michalik	\N
276	Camille Rutherford	\N
277	Dominique Valadié	\N
278	Thibault Vinçon	\N
279	Kris Saddler	\N
280	Tom Gordon	\N
281	David Dobson	\N
282	Vin Hawke	\N
283	Samuel L. Jackson	\N
284	Vincent Cassel	\N
285	Gianni Capaldi	\N
286	Kate Dickie	\N
287	John Hannah	\N
288	Laura Haddock	\N
289	Brian McCardie	\N
290	Samantha Coughlan	\N
291	Nicolette McKeown	\N
292	Mark Holden	\N
293	Birol Tarkan Yıldız	\N
294	Michael Guest	\N
295	Brian Pettifer	\N
296	Mark Wahlberg	\N
297	Nathalie Emmanuel	\N
298	Simu Liu	\N
299	Ali Suliman	\N
300	Juliet Rylance	\N
301	Bear Grylls	\N
302	Michael Landes	\N
303	Paul Guilfoyle	\N
304	Rob Collins	\N
305	Elizabeth Chahin	\N
306	Viktor Åkerblom	\N
307	Zamantha Díaz	\N
308	Cece Valentina	\N
309	Roger Wasserman	\N
310	Sharon Gallardo	\N
311	Andrés Castillo	\N
312	Angie Berube	\N
313	Alani iLongwe	\N
314	Mauricio Adrian	\N
315	Luis del Valle	\N
316	Arturo Duvergé	\N
317	Oscar Best	\N
318	Iban Marrero	\N
319	Carlton Mallard	\N
320	Dakota Johnson	\N
321	Sydney Sweeney	\N
322	Isabela Merced	\N
323	Celeste O'Connor	\N
324	Tahar Rahim	\N
325	Kerry Bishé	\N
326	Adam Scott	\N
327	Emma Roberts	\N
328	Mike Epps	\N
329	Zosia Mamet	\N
330	José María Yázpik	\N
331	Kathy-Ann Hart	\N
332	Josh Drennen	\N
333	Yuma Feldman	\N
334	Miranda Adekoje	\N
335	Deirdre McCourt	\N
336	Naheem Garcia	\N
337	Jill Hennessy	\N
338	Rosemary Crimp	\N
339	Brian Faherty	\N
340	Shaun Bedgood	\N
341	Mike Bash	\N
342	Cilda Shaur	\N
343	Jennifer Ellis	\N
344	Kris Sidberry	\N
345	Erica Souza	\N
346	Rena Maliszewski	\N
347	Michael Malvesti	\N
348	Gopal Lalwani	\N
349	Shawnna Thibodeau	\N
350	Dominique Washington	\N
351	Ryu Jun-yeol	\N
352	Kim Woo-bin	\N
353	Kim Tae-ri	\N
354	So Ji-sub	\N
355	Yum Jung-ah	\N
356	Jo Woo-jin	\N
357	Kim Eui-sung	\N
358	Lee Ha-nee	\N
359	Shin Jung-keun	\N
360	Lee Si-hoon	\N
361	Kim Dae-myung	\N
362	Choi Yu-ri	\N
363	Kim Ki-cheon	\N
364	Yoon Byung-hee	\N
365	Ji Gun-woo	\N
366	Yoon Kyung-ho	\N
367	Ok Ja-yeon	\N
368	Lee Hyun-gul	\N
369	Kim Hae-sook	\N
370	Yoo Jae-myung	\N
371	Jeon Yeo-been	\N
372	Kim Min-seo	\N
373	Lee Sun-hee	\N
374	Baek Hyun-joo	\N
375	Choi Kwang-je	\N
376	Shim Dal-gi	\N
377	Oh Chae-eun	\N
378	Jang Jun-whee	\N
379	Lee Dong-yong	\N
380	Kim Jung-han	\N
381	Kim Chan-hyung	\N
382	Lee Dong-hee	\N
383	Song Ji-hyuk	\N
384	Zendaya	\N
385	Mike Faist	\N
386	Josh O'Connor	\N
387	Darnell Appling	\N
388	Bryan Doo	\N
389	Shane T Harris	\N
390	Nada Despotovich	\N
391	Joan Mcshane	\N
392	Chris Fowler	\N
393	Mary Joe Fernández	\N
394	A.J. Lister	\N
395	Connor Aulson	\N
396	Doria Bramante	\N
397	Christine Dye	\N
398	James Sylva	\N
399	Kenneth A. Osherow	\N
400	Kevin Collins	\N
401	Burgess Byrd	\N
402	Jason Tong	\N
403	Hudson Rivera	\N
404	Noah Eisenberg	\N
405	Emma Davis	\N
406	Naheem Garcia	\N
407	Alex Bancila	\N
408	Jake Jensen	\N
409	Konrad Ryba	\N
410	Hailey Gates	\N
411	Andrew Rogers	\N
412	Beverly Kristenson Helton	\N
413	Brad Gilbert	\N
414	Sam Xu	\N
415	Caleb Schneider	\N
416	Hrithik Roshan	\N
417	Deepika Padukone	\N
418	Anil Kapoor	\N
419	Karan Singh Grover	\N
420	Akshay Oberoi	\N
421	Ashutosh Rana	\N
422	Rishabh Sawhney	\N
423	Sanjeeda Sheikh	\N
424	Sharib Hashmi	\N
425	Mahesh Shetty	\N
426	Banveen Singh	\N
427	Karan Sharma	\N
428	Nishant Khanduja	\N
429	Vinay Varma	\N
430	Talat Aziz	\N
431	Chandan Anand	\N
432	Geeta Sodhi	\N
433	Samvedna Suwalka	\N
434	Chandra Shekhar Dutta	\N
435	Mushtaq Kak	\N
436	Harish Khatri	\N
437	Seerat Mast	\N
438	Ramon Chibb	\N
439	Gurmeet Chawla	\N
440	Viren Kewalramani	\N
441	Namit	\N
442	Vicky Chawla	\N
443	Sanjiv Chopra	\N
444	Indhu Reddy	\N
445	Akarsh Alagh	\N
446	Pushpendra Purchit	\N
447	Krishna Solagama	\N
448	Puneet Bhatia	\N
449	Shiv Dev Singh	\N
450	Usha Sree	\N
451	Abhi Kajuria	\N
452	Sachin Danai	\N
453	Lokesh Bhatta	\N
454	Virender Vashishth	\N
455	Geeta Agrawal Sharma	\N
456	Himani Sahni	\N
457	Ashok Jha	\N
458	Hrushi Poddar	\N
459	Namrata Tiripeni	\N
460	Aditi Sandhya Sharma	\N
461	Harnaam Singh	\N
462	Anisha Pahuja	\N
463	Shahid Gulfam	\N
464	Kapil Kumar	\N
465	Sanjeev Jaiswal	\N
466	Arif Basheer	\N
467	Ayushman Radeef	\N
468	Jayan Rawal	\N
469	Tejan Singh Yadav	\N
470	Sachin Soni	\N
471	Gopal Salaria	\N
472	Shahmir Khan	\N
473	Siddhant Ashar	\N
474	Behzaad Khan	\N
475	Appurva B Suman	\N
476	Aishwarya Airy	\N
477	Arbendra Pratap Singh	\N
478	Sachin Yadav	\N
479	Ayushmaan Sharma	\N
480	Gaurav Govind	\N
481	Ashish Sejwal	\N
482	Kumail Nanjiani	\N
483	Elizabeth Banks	\N
484	Caspar Jennings	\N
485	Tresi Gazal	\N
486	Awkwafina	\N
487	Carol Kane	\N
488	Keegan-Michael Key	\N
489	Danny DeVito	\N
490	David Mitchell	\N
491	Isabela Merced	\N
492	Carlos Alazraqui	\N
493	Brock Baker	\N
494	Gregg Berger	\N
495	Steve Blum	\N
496	Kimberly Brooks	\N
497	Rodger Bumpass	\N
498	Corey Burton	\N
499	Sean Chiplock	\N
500	Amber Lee Connors	\N
501	Ian James Corlett	\N
502	David Cowgill	\N
503	Robin Atkin Downes	\N
504	David Errigo Jr.	\N
505	Bill Farmer	\N
506	Dave Fennoy	\N
507	Keith Ferguson	\N
508	Erin Fitzgerald	\N
509	Grant George	\N
510	David Kaye	\N
511	Danny Mann	\N
512	Zeno Robinson	\N
513	Tara Sands	\N
514	Veronica Taylor	\N
515	Matthew Wood	\N
516	Jake Gyllenhaal	\N
517	Daniela Melchior	\N
518	Conor McGregor	\N
519	Billy Magnussen	\N
520	Jessica Williams	\N
521	Hannah Love Lanier	\N
522	Joaquim de Almeida	\N
523	B.K. Cannon	\N
524	J. D. Pardo	\N
525	Arturo Castro	\N
526	Lukas Gage	\N
527	Post Malone	\N
528	Dominique Columbus	\N
529	Beau Knapp	\N
530	Kevin Carroll	\N
531	Bob Menery	\N
532	Darren Barnet	\N
533	Travis Van Winkle	\N
534	Cesar Báez	\N
535	Franklin Romero Jr.	\N
536	Catfish Jean	\N
537	Chad Guerrero	\N
538	Craig Ng	\N
539	Joe Ciotti	\N
540	Vanessa Gómez Reyes	\N
541	Ellenike Pichardo	\N
542	Braian Valerio	\N
543	Jose Mota Prestol	\N
544	Candy Santana	\N
545	Jonathan Hunt	\N
546	Cannon Smith	\N
547	Ruairi Rhodes	\N
548	Omar Patin	\N
549	Jose A. Diaz	\N
550	Samuel Sang	\N
551	Katherine Read	\N
552	Ty Hemenway	\N
553	Claudia Peña	\N
554	Alexander Bellone	\N
555	Alejandro Bescos	\N
556	Luis Dominguez	\N
557	Jay Hieron	\N
558	Chris Tognoni	\N
559	Mark Smith	\N
560	David Warren	\N
561	Kenny Lorenzetti	\N
562	Bruce Buffer	\N
563	Jon Anik	\N
564	Daniel Cormier	\N
565	Megan Olivi	\N
566	Tommy Lentsch	\N
567	Jensen Ackles	\N
568	Darren Criss	\N
569	Meg Donnelly	\N
570	Stana Katic	\N
571	Jonathan Adams	\N
572	Gideon Adlon	\N
573	Geoffrey Arend	\N
574	Troy Baker	\N
575	Zach Callison	\N
576	Darin De Paul	\N
577	Ato Essandoh	\N
578	Keith Ferguson	\N
579	Will Friedle	\N
580	Jennifer Hale	\N
581	Aldis Hodge	\N
582	Jamie Gray Hyder	\N
583	Erika Ishii	\N
584	David Kaye	\N
585	Matt Lanter	\N
586	Liam McIntyre	\N
587	Lou Diamond Phillips	\N
588	Matt Ryan	\N
589	Keesha Sharp	\N
590	Harry Shum Jr.	\N
591	Jimmi Simpson	\N
592	Kirsten Dunst	\N
593	Wagner Moura	\N
594	Cailee Spaeny	\N
595	Stephen McKinley Henderson	\N
596	Nelson Lee	\N
597	Nick Offerman	\N
598	Jefferson White	\N
599	Evan Lai	\N
600	Vince Pisani	\N
601	Justin James Boykin	\N
602	Jess Matney	\N
603	Greg Hill	\N
604	Edmund Donovan	\N
605	Sonoya Mizuno	\N
606	Tim James	\N
607	Simeon Freeman	\N
608	James Yaegashi	\N
609	Dean Grimes	\N
610	Alexa Mansour	\N
611	Martha B. Knighton	\N
612	Melissa Saint-Amand	\N
613	Karl Glusman	\N
614	Jin Ha	\N
615	Jojo T. Gibbs	\N
616	Jared Shaw	\N
617	Justin Garza	\N
618	Brian Philpot	\N
619	Tywaun Tornes	\N
620	Juani Feliz	\N
621	Jesse Plemons	\N
622	John Newberg	\N
623	Kevin Howell	\N
624	Ernest 'Scooby' Rogers	\N
625	Robert Perry Bierman	\N
626	Joe Manuel Gallegos Jr.	\N
627	Christopher Cocke	\N
628	Ryan Austin Bryant	\N
629	Jeff Bosley	\N
630	Brent Moorer Gaskins	\N
631	Evan Holtzman	\N
632	Lauren Marie Gordon	\N
633	Kevin Kedgley	\N
634	Timothy LaForce	\N
635	Cora Maple Lindell	\N
636	Cody Marshall	\N
637	Randy S. Love	\N
638	Petey Nguyễn	\N
639	LePrix Robinson	\N
640	Kim Rosen	\N
641	Daniel Patrick Shook	\N
642	Robert Tinsley	\N
643	Jaclyn White	\N
644	Temper Lavigne	\N
645	Cillian Murphy	\N
646	Emily Blunt	\N
647	Matt Damon	\N
648	Robert Downey Jr.	\N
649	Florence Pugh	\N
650	Josh Hartnett	\N
651	Casey Affleck	\N
652	Rami Malek	\N
653	Kenneth Branagh	\N
654	Benny Safdie	\N
655	Jason Clarke	\N
656	Dylan Arnold	\N
657	Tom Conti	\N
658	James D'Arcy	\N
659	David Dastmalchian	\N
660	Dane DeHaan	\N
661	Alden Ehrenreich	\N
662	Tony Goldwyn	\N
663	Jefferson Hall	\N
664	David Krumholtz	\N
665	Matthew Modine	\N
666	Scott Grimes	\N
667	Kurt Koehler	\N
668	John Gowans	\N
669	Macon Blair	\N
670	Harry Groener	\N
671	Gregory Jbara	\N
672	Ted King	\N
673	Tim DeKay	\N
674	Steven Houska	\N
675	Petrie Willink	\N
676	Matthias Schweighöfer	\N
677	Alex Wolff	\N
678	Josh Zuckerman	\N
679	Rory Keane	\N
680	Michael Angarano	\N
681	Emma Dumont	\N
682	Sadie Stratton	\N
683	Britt Kyle	\N
684	Guy Burnet	\N
685	Tom Jenkins	\N
686	Louise Lombard	\N
687	Michael Andrew Baker	\N
688	Jeff Hephner	\N
689	Olli Haaskivi	\N
690	David Rysdahl	\N
691	Josh Peck	\N
692	Jack Quaid	\N
693	Brett DelBuono	\N
694	Gustaf Skarsgård	\N
695	James Urbaniak	\N
696	Trond Fausa Aurvåg	\N
697	Devon Bostick	\N
698	Danny Deferrari	\N
699	Christopher Denham	\N
700	Jessica Erin Martin	\N
701	Ronald Auguste	\N
702	Máté Haumann	\N
703	Olivia Thirlby	\N
704	Jack Cutmore-Scott	\N
705	Harrison Gilbertson	\N
706	James Remar	\N
707	Will Roberts	\N
708	Pat Skipper	\N
709	Steve Coulter	\N
710	Jeremy John Wells	\N
711	Sean Avery	\N
712	Adam Kroeger	\N
713	Drew Kenney	\N
714	Bryce Johnson	\N
715	Flora Nolan	\N
716	Kerry Westcott	\N
717	Christina Hogue	\N
718	Clay Bunker	\N
719	Tyler Beardsley	\N
720	Maria Teresa Zuppetta	\N
721	Kate French	\N
722	Gary Oldman	\N
723	Hap Lawrence	\N
724	Meg Schimelpfenig	\N
\.


--
-- Data for Name: acteur_films; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.acteur_films (acteur_id, films_id) FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
7	1
8	1
9	1
10	1
11	1
12	1
13	1
14	1
15	1
16	1
17	1
18	1
19	1
20	1
21	1
22	1
23	2
24	2
25	2
26	2
27	2
28	2
29	2
30	2
31	2
32	2
33	2
34	2
35	2
36	3
37	3
38	3
39	3
40	3
41	3
42	3
43	3
44	3
45	3
46	3
47	3
48	4
49	4
50	4
51	4
52	4
53	4
54	4
55	4
56	4
57	4
58	4
59	4
60	4
61	4
62	4
63	4
64	4
65	4
66	4
67	4
68	4
69	4
70	4
71	4
72	4
73	4
74	4
75	4
76	4
77	4
78	4
79	4
80	4
81	4
82	4
83	4
84	4
85	4
86	4
87	4
88	4
89	4
90	4
91	4
92	4
93	4
94	4
95	4
96	4
97	4
98	4
99	4
100	4
101	4
102	4
103	4
104	4
105	5
106	5
107	5
108	5
109	5
110	5
111	5
112	5
113	5
114	5
115	5
116	5
117	5
118	5
119	5
120	5
121	5
122	5
123	5
124	5
125	5
126	5
127	5
128	5
129	5
130	5
131	5
132	5
133	5
134	5
135	5
136	5
137	5
138	5
139	5
140	5
141	5
142	5
143	5
144	5
145	5
146	5
147	5
148	5
149	5
150	5
151	5
152	5
153	5
154	5
155	5
156	5
157	5
158	5
159	5
160	5
161	5
162	5
163	5
164	5
165	5
166	5
167	5
168	5
169	5
170	5
171	5
172	5
173	5
174	5
175	5
176	5
177	5
178	5
179	5
180	5
181	5
182	5
183	5
184	5
185	5
186	5
187	5
188	5
189	5
190	5
191	5
192	5
193	5
194	5
195	5
196	5
197	5
198	5
199	5
200	5
201	5
202	5
203	5
204	5
205	6
206	6
207	6
208	6
209	6
210	6
211	6
212	6
213	6
214	6
215	6
216	6
217	6
218	6
219	6
220	6
221	6
222	6
223	6
224	6
225	6
226	6
227	6
228	6
229	6
230	6
231	6
232	6
233	6
234	6
235	6
236	6
237	6
238	6
239	6
240	6
241	6
242	7
243	7
244	7
245	7
246	7
247	7
248	7
249	7
250	7
251	7
252	7
253	7
254	7
255	7
256	7
257	7
258	7
259	7
260	7
261	8
262	8
263	8
264	8
265	8
266	8
267	8
268	8
269	8
270	8
271	8
272	8
273	8
274	8
275	8
276	8
277	8
278	8
279	9
280	9
281	9
282	9
283	10
284	10
285	10
286	10
287	10
288	10
289	10
290	10
291	10
292	10
293	10
294	10
295	10
296	11
297	11
298	11
299	11
300	11
301	11
302	11
303	11
304	11
305	11
306	11
307	11
308	11
309	11
310	11
311	11
312	11
313	11
314	11
315	11
316	11
317	11
318	11
319	11
320	12
321	12
322	12
323	12
324	12
325	12
326	12
327	12
328	12
329	12
330	12
331	12
332	12
333	12
334	12
335	12
336	12
337	12
338	12
339	12
340	12
341	12
342	12
343	12
344	12
345	12
346	12
347	12
348	12
349	12
350	12
351	13
352	13
353	13
354	13
355	13
356	13
357	13
358	13
359	13
360	13
361	13
362	13
363	13
364	13
365	13
366	13
367	13
368	13
369	13
370	13
371	13
372	13
373	13
374	13
375	13
376	13
377	13
378	13
379	13
380	13
381	13
382	13
383	13
384	14
385	14
386	14
387	14
388	14
389	14
390	14
391	14
392	14
393	14
394	14
395	14
396	14
397	14
398	14
399	14
400	14
401	14
402	14
403	14
404	14
405	14
406	14
407	14
408	14
409	14
410	14
411	14
412	14
413	14
414	14
415	14
416	15
417	15
418	15
419	15
420	15
421	15
422	15
423	15
424	15
425	15
426	15
427	15
428	15
429	15
430	15
431	15
432	15
433	15
434	15
435	15
436	15
437	15
438	15
439	15
440	15
441	15
442	15
443	15
444	15
445	15
446	15
447	15
448	15
449	15
450	15
451	15
452	15
453	15
454	15
455	15
456	15
457	15
458	15
459	15
460	15
461	15
462	15
463	15
464	15
465	15
466	15
467	15
468	15
469	15
470	15
471	15
472	15
473	15
474	15
475	15
476	15
477	15
478	15
479	15
480	15
481	15
482	16
483	16
484	16
485	16
486	16
487	16
488	16
489	16
490	16
491	16
492	16
493	16
494	16
495	16
496	16
497	16
498	16
499	16
500	16
501	16
502	16
503	16
504	16
505	16
506	16
507	16
508	16
509	16
510	16
511	16
512	16
513	16
514	16
515	16
516	17
517	17
518	17
519	17
520	17
521	17
522	17
523	17
524	17
525	17
526	17
527	17
528	17
529	17
530	17
531	17
532	17
533	17
534	17
535	17
536	17
537	17
538	17
539	17
540	17
541	17
542	17
543	17
544	17
545	17
546	17
547	17
548	17
549	17
550	17
551	17
552	17
553	17
554	17
555	17
556	17
557	17
558	17
559	17
560	17
561	17
562	17
563	17
564	17
565	17
566	17
567	18
568	18
569	18
570	18
571	18
572	18
573	18
574	18
575	18
576	18
577	18
578	18
579	18
580	18
581	18
582	18
583	18
584	18
585	18
586	18
587	18
588	18
589	18
590	18
591	18
592	19
593	19
594	19
595	19
596	19
597	19
598	19
599	19
600	19
601	19
602	19
603	19
604	19
605	19
606	19
607	19
608	19
609	19
610	19
611	19
612	19
613	19
614	19
615	19
616	19
617	19
618	19
619	19
620	19
621	19
622	19
623	19
624	19
625	19
626	19
627	19
628	19
629	19
630	19
631	19
632	19
633	19
634	19
635	19
636	19
637	19
638	19
639	19
640	19
641	19
642	19
643	19
644	19
645	20
646	20
647	20
648	20
649	20
650	20
651	20
652	20
653	20
654	20
655	20
656	20
657	20
658	20
659	20
660	20
661	20
662	20
663	20
664	20
665	20
666	20
667	20
668	20
669	20
670	20
671	20
672	20
673	20
674	20
675	20
676	20
677	20
678	20
679	20
680	20
681	20
682	20
683	20
684	20
685	20
686	20
687	20
688	20
689	20
690	20
691	20
692	20
693	20
694	20
695	20
696	20
697	20
698	20
699	20
700	20
701	20
702	20
703	20
704	20
705	20
706	20
707	20
708	20
709	20
710	20
711	20
712	20
713	20
714	20
715	20
716	20
717	20
718	20
719	20
720	20
721	20
722	20
723	20
724	20
\.


--
-- Data for Name: commentaire; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.commentaire (id, users_id, films_id, commentaire, date_commentaire, moderation, rating) FROM stdin;
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20230912145914	2024-05-02 07:08:38	136
DoctrineMigrations\\Version20230919112543	2024-05-02 07:08:38	1
DoctrineMigrations\\Version20231003135151	2024-05-02 07:08:38	29
DoctrineMigrations\\Version20231005134734	2024-05-02 07:08:38	7
DoctrineMigrations\\Version20231009122523	2024-05-02 07:08:38	1
DoctrineMigrations\\Version20231010070007	2024-05-02 07:08:38	7
DoctrineMigrations\\Version20231010085815	2024-05-02 07:08:38	1
DoctrineMigrations\\Version20231010085917	2024-05-02 07:08:38	1
DoctrineMigrations\\Version20231010130144	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20231010134409	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20231010145951	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20231017091941	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20231017142939	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20231019073120	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20231019073258	2024-05-02 07:08:38	5
DoctrineMigrations\\Version20231019073736	2024-05-02 07:08:38	3
DoctrineMigrations\\Version20231019092640	2024-05-02 07:08:38	7
DoctrineMigrations\\Version20231106225240	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20231106234125	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240307070336	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240311144729	2024-05-02 07:08:38	1
DoctrineMigrations\\Version20240311154037	2024-05-02 07:08:38	2
DoctrineMigrations\\Version20240312152000	2024-05-02 07:08:38	5
DoctrineMigrations\\Version20240313112907	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240314073225	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240322152012	2024-05-02 07:08:38	1
DoctrineMigrations\\Version20240322152450	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240322180536	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240322180905	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240323150845	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240323235114	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240324001026	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240324001456	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240324003315	2024-05-02 07:08:38	0
DoctrineMigrations\\Version20240429142939	2024-05-02 07:08:38	1
DoctrineMigrations\\Version20240502071351	2024-05-02 07:14:06	1
\.


--
-- Data for Name: favorie; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.favorie (id, users_id, films_id) FROM stdin;
\.


--
-- Data for Name: films; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.films (id, name, description, moderation, date_sortie) FROM stdin;
1	Godzilla x Kong : Le Nouvel Empire	Le surpuissant Kong et le redoutable Godzilla sont opposés à une force colossale terrée dans notre monde, qui menace leur existence et la nôtre. "Godzilla x Kong : The New Empire" approfondit l'histoire de ces Titans et leurs origines, ainsi que les mystères de Skull Island et au-delà, tout en levant le voile sur la bataille mythique qui a forgé ces êtres extraordinaires et les a liés à l'humanité à jamais.	\N	2024-03-27
2	Ape vs. Mecha Ape		\N	2023-03-24
3	No Way Up	Un avion de ligne s'immobilise dangereusement près du bord d'un ravin, les passagers et l'équipage survivants étant piégés dans une poche d'air. Leur réserve d'air s'épuisant rapidement, une lutte cauchemardesque pour la survie s'engage alors que des dangers les guettent de toutes parts.	\N	2024-01-18
4	Rebel Moon – Partie 2 : L'Entailleuse	Les rebelles se préparent à braver les impitoyables forces du Monde-Mère, des liens indestructibles se forgent, des héros émergent et des légendes naissent.	\N	2024-04-19
5	Dune : Deuxième partie	Le voyage mythique de Paul Atreides qui s'allie à Chani et aux Fremen dans sa quête de vengeance envers les conspirateurs qui ont anéanti sa famille. Devant choisir entre l'amour de sa vie et le destin de l'univers, il fera tout pour éviter un terrible futur que lui seul peut prédire.	\N	2024-02-27
6	Kung Fu Panda 4	Après trois aventures dans lesquelles le guerrier dragon Po a combattu les maîtres du mal les plus redoutables grâce à un courage et des compétences en arts martiaux inégalés, le destin va de nouveau frapper à sa porte pour l'inviter à enfin se reposer. Plus précisément, pour être nommé chef spirituel de la vallée de la Paix.	\N	2024-03-02
7	Immaculée	Cecilia, une jeune femme de foi américaine, est chaleureusement accueillie dans un illustre couvent isolé de la campagne italienne, où elle se voit offrir un nouveau rôle. L'accueil est chaleureux, mais Cecilia comprend rapidement que sa nouvelle demeure abrite un sinistre secret et que des choses terribles s'y produisent.	\N	2024-03-20
8	Les trois mousquetaires : Milady	Constance Bonacieux est enlevée sous les yeux de D'Artagnan. Dans une quête effrénée pour la sauver, le jeune mousquetaire est contraint de s'allier à la mystérieuse Milady de Winter. Alors que la guerre est déclarée, Athos, Porthos et Aramis ont déjà rejoint le front. Par ailleurs, un terrible secret du passé va briser toutes les anciennes alliances.	\N	2023-12-13
9	Mission Spitfire	Pendant la deuxième guerre mondiale, le Lieutenant Edward Barnes doit effectuer une mission de vie ou de mort au-dessus de Berlin dans son Spitfire non armé pour obtenir des preuves photographiques et sauver la vie de ses soldats.	\N	2022-05-13
10	Damaged	Lorsqu’un meurtrier sadique fait surface en Écosse, un détective de la police de Chicago se joint à la traque dans l’espoir d’arrêter ce tueur en série rituel avant qu’il ne fasse sa prochaine victime.	\N	2024-04-12
11	Arthur the King	Mikael Lindnord, le capitaine d'une équipe suédoise de courses d'aventure, rencontre un chien errant, blessé, lors d'une course de 643 kilomètres et 740 mètres (400 miles) à travers les jungles équatoriennes. Tout commence par un lancé de boulette de viande, ce qui conduit le chien à suivre l'équipe à travers certains des terrains les plus difficiles de la planète. Mikael décide finalement d'adopter ce chien et de le ramener avec lui en Suède.	\N	2024-03-15
12	Madame Web	« Pendant ce temps, dans un autre univers... » Dans une variation du genre classique, Madame Web raconte les origines de l'une des plus énigmatiques héroïnes des bandes dessinées Marvel. Le suspense met en vedette Dakota Johnson dans le rôle de Cassandra Webb, une ambulancière de Manhattan ayant des dons de voyance. Contrainte de faire face à des révélations sur son passé, elle se lie d'amitié avec trois jeunes femmes destinées à un avenir de superhéroïnes… si elles parviennent à survivre aux dangers du présent.	\N	2024-02-14
13	Alienoid : Les Protecteurs du futur	Afin d’anéantir la menace d’Aliens capable de posséder les corps humains, un gardien est envoyé du futur pour traquer ces envahisseurs. Mais lorsque Séoul est attaqué, ce protecteur comprend qu'il ne s’en sortira pas seul. Des siècles plus tôt, une mystérieuse élue parcourt le pays à la recherche de l'alien originel. Des quêtes parallèles de ces voyageurs du temps dépendra le salut de l'humanité.	\N	2022-07-20
14	Challengers	Une joueuse de tennis devenue entraîneuse, Tashi, décide de se consacrer à la carrière de son mari, Art, le faisant passer d'un joueur médiocre en un champion du Grand Chelem de renommée mondiale. Pour le sortir d'une récente série de défaites, elle le fait participer à un tournoi "Challenger" où il se retrouve face à Patrick, son ancien meilleur ami et l'ancien petit-ami de Tashi.	\N	2024-04-18
15	Fighter	Les meilleurs aviateurs de l'IAF se réunissent face à un danger imminent pour former les Air Dragons. Fighter dévoile sa camaraderie, sa fraternité et ses combats, internes et externes.	\N	2024-01-24
16	Migration	La routine règne chez les Colvert. Si papa Mack préfère garder les siens bien à l’abri dans leur étang de la Nouvelle-Angleterre, maman Pam veut changer les choses et faire découvrir le monde à leurs deux enfants, Dax l’ado et Gwen la cadette. Après qu’une famille de canards migrateurs s’est enflammée pour des récits parlant d’endroits très lointains, Pam persuade Mack d’embarquer la famille dans un long périple, depuis la ville de New York jusque sous les tropiques, en Jamaïque. Tandis que les Colvert s’envolent vers le Sud pour l’hiver, leurs projets bien rodés tombent rapidement à l’eau. Une expérience qui les pousse alors à étendre leurs horizons, à s’ouvrir à de nouveaux amis et à aller au-delà de leurs espoirs les plus fous, tout en apprenant davantage sur chacun et sur soi-même	\N	2023-12-06
17	Road House	Dalton, un ancien combattant de l'UFC tente d'échapper à son sombre passé et à son penchant pour la violence. Il est repéré par Frankie, propriétaire d'un relais routier dans les Keys de Floride. Elle l'engage comme nouveau videur dans l'espoir d'empêcher un gang violent, travaillant pour le patron du crime Brandt, de détruire son bar bien-aimé.	\N	2024-03-08
18	Justice League : Crisis on Infinite Earths Partie 2	Une armée infinie de DÉMONS DE L’OMBRE cherchant à tout prix à en finir avec les réalités déferle dans notre monde et sur toutes les Terres parallèles ! L’équipe la plus puissante de métahumains jamais réunie est la seule à pouvoir les affronter. Cependant, même la force combinée de Superman, de Batman, de Wonder Woman, de Green Lantern et des autres superhéros n’arrive pas à ralentir l’assaut de cette horde invisible. Quelle est la force mystérieuse qui les anime ? Les secrets enfouis depuis longtemps de Monitor et de Supergirl risquent-ils d’anéantir la dernière défense des héros ?	\N	2024-04-22
19	Civil War	Dans un futur proche où les États-Unis sont au bord de l'effondrement et où des journalistes embarqués courent pour raconter la plus grande histoire de leur vie : La fin de l'Amérique telle que nous la connaissons.	\N	2024-04-10
20	Oppenheimer	En 1942, convaincus que l'Allemagne nazie est en train de développer une arme nucléaire, les États-Unis initient, dans le plus grand secret, le "Projet Manhattan" destiné à mettre au point la première bombe atomique de l’histoire. Pour piloter ce dispositif, le gouvernement engage J. Robert Oppenheimer, brillant physicien, qui sera bientôt surnommé "le père de la bombe atomique". C'est dans le laboratoire ultra-secret de Los Alamos, au cœur du désert du Nouveau-Mexique, que le scientifique et son équipe mettent au point une arme révolutionnaire dont les conséquences, vertigineuses, continuent de peser sur le monde actuel…	\N	2023-07-19
\.


--
-- Data for Name: films_likes_films; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.films_likes_films (films_id, likes_films_id) FROM stdin;
\.


--
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.genre (id, name) FROM stdin;
5	Science Fiction
7	Horror
17	Comedy
20	Mystery
22	Adventure
27	History
29	Crime
30	Thriller
37	Fantasy
40	Romance
43	War
48	Family
51	Animation
55	Action
56	Drama
\.


--
-- Data for Name: genre_films; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.genre_films (genre_id, films_id) FROM stdin;
5	2
7	3
17	6
20	7
22	8
27	9
29	10
30	10
37	13
40	14
43	15
48	16
51	18
55	19
56	19
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.image (id, imagefilm_id, titre, photo, path) FROM stdin;
1	1	Poster : Godzilla x Kong : Le Nouvel Empire	nKnWr062zhRvk48NtK27zz3oLgS.jpg	\N
2	2	Poster : Ape vs. Mecha Ape	dJaIw8OgACelojyV6YuVsOhtTLO.jpg	\N
3	3	Poster : No Way Up	hu40Uxp9WtpL34jv3zyWLb5zEVY.jpg	\N
4	4	Poster : Rebel Moon – Partie 2 : L'Entailleuse	1BfXp9BanCSs5DxrOt7YnbnWoX5.jpg	\N
5	5	Poster : Dune : Deuxième partie	iRNbRAIGQQr5diGnjpwJFm0dgt4.jpg	\N
6	6	Poster : Kung Fu Panda 4	kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg	\N
7	7	Poster : Immaculée	aRhtHbgFGVKI5LJHcbSqQ0WbNib.jpg	\N
8	8	Poster : Les trois mousquetaires : Milady	oxPdfTJLfCZauJiUdhHe5lA4bhD.jpg	\N
9	9	Poster : Mission Spitfire	wdMf8PZr6oMXkpAqIvmOT1xY1Jm.jpg	\N
10	10	Poster : Damaged	sUjbd7imUQxslh5T5PsDf6lXTb9.jpg	\N
11	11	Poster : Arthur the King	gxVcBc4VM0kAg9wX4HVg6KJHG46.jpg	\N
12	12	Poster : Madame Web	xAHGuVQFTbSbbdeUbkfrAY8kf2m.jpg	\N
13	13	Poster : Alienoid : Les Protecteurs du futur	sYCUwnywPbN8GN3LUJ1kCYyKoH4.jpg	\N
14	14	Poster : Challengers	H6vke7zGiuLsz4v4RPeReb9rsv.jpg	\N
15	15	Poster : Fighter	zDZowwb9GZGEctAu2PCpjiPQAMM.jpg	\N
16	16	Poster : Migration	3xGLxvuVvLoPhrCxkofkczfR6R5.jpg	\N
17	17	Poster : Road House	xAHthaVYtwADKYORPkLzd6MgX0P.jpg	\N
18	18	Poster : Justice League : Crisis on Infinite Earths Partie 2	hEZAK5WyUMxzZzdFiCvlw0if7Ty.jpg	\N
19	19	Poster : Civil War	4V06xpCUesnzXvkQav1q3RRlwxh.jpg	\N
20	20	Poster : Oppenheimer	boAUuJBeID7VNp4L7LNMQs8mfQS.jpg	\N
\.


--
-- Data for Name: likes_films; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.likes_films (id, likes_films, film_id, user_id, rating) FROM stdin;
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.notes (id, films_id, date, note) FROM stdin;
\.


--
-- Data for Name: producteur; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.producteur (id, name, nickname) FROM stdin;
1	Thomas Tull	\N
2	Jon Jashni	\N
3	Mary Parent	\N
4	Alex Garcia	\N
5	Eric McLeod	\N
6	Brian Rogers	\N
7	David Michael Latt	\N
8	Andy Mayson	\N
9	Annalise Davis	\N
10	Deborah Snyder	\N
11	Eric Newman	\N
12	Wesley Coller	\N
13	Zack Snyder	\N
14	Denis Villeneuve	\N
15	Mary Parent	\N
16	Cale Boyter	\N
17	Tanya Lapointe	\N
18	Patrick McCormick	\N
19	Rebecca Huntley	\N
20	Sydney Sweeney	\N
21	David Bernad	\N
22	Jonathan Davino	\N
23	Teddy Schwarzman	\N
24	Michael Heimler	\N
25	Dimitri Rassam	\N
26	Paul Aniello	\N
27	Roman Kopelevich	\N
28	Mark Canton	\N
29	Tucker Tooley	\N
30	Courtney Solomon	\N
31	Tessa Tooley	\N
32	Lorenzo di Bonaventura	\N
33	Kim Sung-min	\N
34	Ahn Soo-hyun	\N
35	Choi Dong-hoon	\N
36	Amy Pascal	\N
37	Rachel O'Connor	\N
38	Luca Guadagnino	\N
39	Zendaya	\N
40	Siddharth Anand	\N
41	Ajit Andhare	\N
42	Ramon Chibb	\N
43	Kevin Vaz	\N
44	Anku Pande	\N
45	Mamta Anand	\N
46	Chris Meledandri	\N
47	Joel Silver	\N
48	James Krieg	\N
49	Kimberly S. Moreau	\N
50	Andrew Macdonald	\N
51	Allon Reich	\N
52	Gregory Goodman	\N
53	Christopher Nolan	\N
54	Emma Thomas	\N
55	Charles Roven	\N
\.


--
-- Data for Name: producteur_films; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.producteur_films (producteur_id, films_id) FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
7	2
8	3
9	3
10	4
11	4
12	4
13	4
14	5
15	5
16	5
17	5
18	5
19	6
20	7
21	7
22	7
23	7
24	7
25	8
26	10
27	10
28	11
29	11
30	11
31	11
32	12
33	13
34	13
35	13
36	14
37	14
38	14
39	14
40	15
41	15
42	15
43	15
44	15
45	15
46	16
47	17
48	18
49	18
50	19
51	19
52	19
53	20
54	20
55	20
\.


--
-- Data for Name: realisateur; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.realisateur (id, name, nickname) FROM stdin;
1	Adam Wingard	\N
2	Marc Gottlieb	\N
3	Claudio Fäh	\N
4	Zack Snyder	\N
5	Denis Villeneuve	\N
6	Mike Mitchell	\N
7	Michael Mohan	\N
8	Martin Bourboulon	\N
9	Callum Burn	\N
10	Terry McDonough	\N
11	Simon Cellan Jones	\N
12	S.J. Clarkson	\N
13	Choi Dong-hoon	\N
14	Luca Guadagnino	\N
15	Siddharth Anand	\N
16	Benjamin Renner	\N
17	Doug Liman	\N
18	Jeff Wamester	\N
19	Alex Garland	\N
20	Christopher Nolan	\N
\.


--
-- Data for Name: realisateur_films; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.realisateur_films (realisateur_id, films_id) FROM stdin;
1	1
2	2
3	3
4	4
5	5
6	6
7	7
8	8
9	9
10	10
11	11
12	12
13	13
14	14
15	15
16	16
17	17
18	18
19	19
20	20
\.


--
-- Data for Name: reset_password_request; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.reset_password_request (id, user_id, selector, hashed_token, requested_at, expires_at) FROM stdin;
1	1	2uA61kSnp5TIw4WJZDst	zbr1z5TGhod0g3dsAyVN7Iwkl2hYZjr9q0wBPMcbN9k=	2024-05-02 07:10:14	2024-05-02 08:10:14
2	2	tgaoXgKRsBsB2eyIDPLj	22OL4z2df6QpRB6dn2XHCNOZJNJ5ijehEmQQTNZHhrU=	2024-05-02 09:40:04	2024-05-02 10:40:04
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.users (id, notes_id, email, roles, password, username, name, nickname) FROM stdin;
1	\N	luboys2002@gmail.com	[]	$2y$13$c71Hhf/eVTh7S20VGBBjRORgw.aa3rtfpXhK3kN0EqvroJkBFO2H.	test	ozdemir	lucas
2	\N	admin@beaupeyrat.com	["ROLE_ADMIN"]	$2y$13$mc/2DjAnoTCi02VcQh0IBOYmb9A09NP8cQPjxlCsTr0Tib.xLMpwa	admin	test1	test2
3	\N	admin1@beaupeyrat.com	["ROLE_ADMIN"]	$2y$13$AMiUaGAcPn//qhUUuZjs4.VNkym5a.vkVV6Pye1FzmB3X8F52kko.	admin	test1	test2
\.


--
-- Data for Name: users_likes_films; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.users_likes_films (users_id, likes_films_id) FROM stdin;
\.


--
-- Name: acteur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.acteur_id_seq', 724, true);


--
-- Name: commentaire_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.commentaire_id_seq', 1, false);


--
-- Name: favorie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.favorie_id_seq', 1, false);


--
-- Name: films_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.films_id_seq', 20, true);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.genre_id_seq', 58, true);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.image_id_seq', 20, true);


--
-- Name: likes_films_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.likes_films_id_seq', 1, false);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.notes_id_seq', 1, false);


--
-- Name: producteur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.producteur_id_seq', 55, true);


--
-- Name: realisateur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.realisateur_id_seq', 20, true);


--
-- Name: reset_password_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.reset_password_request_id_seq', 3, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: acteur_films acteur_films_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.acteur_films
    ADD CONSTRAINT acteur_films_pkey PRIMARY KEY (acteur_id, films_id);


--
-- Name: acteur acteur_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.acteur
    ADD CONSTRAINT acteur_pkey PRIMARY KEY (id);


--
-- Name: commentaire commentaire_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT commentaire_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: favorie favorie_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.favorie
    ADD CONSTRAINT favorie_pkey PRIMARY KEY (id);


--
-- Name: films_likes_films films_likes_films_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.films_likes_films
    ADD CONSTRAINT films_likes_films_pkey PRIMARY KEY (films_id, likes_films_id);


--
-- Name: films films_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.films
    ADD CONSTRAINT films_pkey PRIMARY KEY (id);


--
-- Name: genre_films genre_films_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.genre_films
    ADD CONSTRAINT genre_films_pkey PRIMARY KEY (genre_id, films_id);


--
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: likes_films likes_films_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.likes_films
    ADD CONSTRAINT likes_films_pkey PRIMARY KEY (id);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: producteur_films producteur_films_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.producteur_films
    ADD CONSTRAINT producteur_films_pkey PRIMARY KEY (producteur_id, films_id);


--
-- Name: producteur producteur_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.producteur
    ADD CONSTRAINT producteur_pkey PRIMARY KEY (id);


--
-- Name: realisateur_films realisateur_films_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.realisateur_films
    ADD CONSTRAINT realisateur_films_pkey PRIMARY KEY (realisateur_id, films_id);


--
-- Name: realisateur realisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.realisateur
    ADD CONSTRAINT realisateur_pkey PRIMARY KEY (id);


--
-- Name: reset_password_request reset_password_request_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.reset_password_request
    ADD CONSTRAINT reset_password_request_pkey PRIMARY KEY (id);


--
-- Name: users_likes_films users_likes_films_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.users_likes_films
    ADD CONSTRAINT users_likes_films_pkey PRIMARY KEY (users_id, likes_films_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_11ba68c939610ee; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_11ba68c939610ee ON public.notes USING btree (films_id);


--
-- Name: idx_1483a5e9fc56f556; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_1483a5e9fc56f556 ON public.users USING btree (notes_id);


--
-- Name: idx_67f068bc67b3b43d; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_67f068bc67b3b43d ON public.commentaire USING btree (users_id);


--
-- Name: idx_67f068bc939610ee; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_67f068bc939610ee ON public.commentaire USING btree (films_id);


--
-- Name: idx_721066d7567f5183; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_721066d7567f5183 ON public.likes_films USING btree (film_id);


--
-- Name: idx_721066d7a76ed395; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_721066d7a76ed395 ON public.likes_films USING btree (user_id);


--
-- Name: idx_73ead5944296d31f; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_73ead5944296d31f ON public.genre_films USING btree (genre_id);


--
-- Name: idx_73ead594939610ee; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_73ead594939610ee ON public.genre_films USING btree (films_id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_7ce748aa76ed395; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_7ce748aa76ed395 ON public.reset_password_request USING btree (user_id);


--
-- Name: idx_7de7716367b3b43d; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_7de7716367b3b43d ON public.favorie USING btree (users_id);


--
-- Name: idx_7de77163939610ee; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_7de77163939610ee ON public.favorie USING btree (films_id);


--
-- Name: idx_7fdc262a939610ee; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_7fdc262a939610ee ON public.producteur_films USING btree (films_id);


--
-- Name: idx_7fdc262aab9bb300; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_7fdc262aab9bb300 ON public.producteur_films USING btree (producteur_id);


--
-- Name: idx_82132ea0939610ee; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_82132ea0939610ee ON public.acteur_films USING btree (films_id);


--
-- Name: idx_82132ea0da6f574a; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_82132ea0da6f574a ON public.acteur_films USING btree (acteur_id);


--
-- Name: idx_85a55a2567b3b43d; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_85a55a2567b3b43d ON public.users_likes_films USING btree (users_id);


--
-- Name: idx_85a55a25c0973ab2; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_85a55a25c0973ab2 ON public.users_likes_films USING btree (likes_films_id);


--
-- Name: idx_95ae839b939610ee; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_95ae839b939610ee ON public.films_likes_films USING btree (films_id);


--
-- Name: idx_95ae839bc0973ab2; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_95ae839bc0973ab2 ON public.films_likes_films USING btree (likes_films_id);


--
-- Name: idx_af7d8d4c939610ee; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_af7d8d4c939610ee ON public.realisateur_films USING btree (films_id);


--
-- Name: idx_af7d8d4cf1d8422e; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_af7d8d4cf1d8422e ON public.realisateur_films USING btree (realisateur_id);


--
-- Name: idx_c53d045f51e8c8; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_c53d045f51e8c8 ON public.image USING btree (imagefilm_id);


--
-- Name: uniq_1483a5e9e7927c74; Type: INDEX; Schema: public; Owner: app
--

CREATE UNIQUE INDEX uniq_1483a5e9e7927c74 ON public.users USING btree (email);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: app
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: notes fk_11ba68c939610ee; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT fk_11ba68c939610ee FOREIGN KEY (films_id) REFERENCES public.films(id);


--
-- Name: users fk_1483a5e9fc56f556; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_1483a5e9fc56f556 FOREIGN KEY (notes_id) REFERENCES public.notes(id);


--
-- Name: commentaire fk_67f068bc67b3b43d; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT fk_67f068bc67b3b43d FOREIGN KEY (users_id) REFERENCES public.users(id);


--
-- Name: commentaire fk_67f068bc939610ee; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.commentaire
    ADD CONSTRAINT fk_67f068bc939610ee FOREIGN KEY (films_id) REFERENCES public.films(id);


--
-- Name: likes_films fk_721066d7567f5183; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.likes_films
    ADD CONSTRAINT fk_721066d7567f5183 FOREIGN KEY (film_id) REFERENCES public.films(id);


--
-- Name: likes_films fk_721066d7a76ed395; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.likes_films
    ADD CONSTRAINT fk_721066d7a76ed395 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: genre_films fk_73ead5944296d31f; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.genre_films
    ADD CONSTRAINT fk_73ead5944296d31f FOREIGN KEY (genre_id) REFERENCES public.genre(id) ON DELETE CASCADE;


--
-- Name: genre_films fk_73ead594939610ee; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.genre_films
    ADD CONSTRAINT fk_73ead594939610ee FOREIGN KEY (films_id) REFERENCES public.films(id) ON DELETE CASCADE;


--
-- Name: reset_password_request fk_7ce748aa76ed395; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.reset_password_request
    ADD CONSTRAINT fk_7ce748aa76ed395 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: favorie fk_7de7716367b3b43d; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.favorie
    ADD CONSTRAINT fk_7de7716367b3b43d FOREIGN KEY (users_id) REFERENCES public.users(id);


--
-- Name: favorie fk_7de77163939610ee; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.favorie
    ADD CONSTRAINT fk_7de77163939610ee FOREIGN KEY (films_id) REFERENCES public.films(id);


--
-- Name: producteur_films fk_7fdc262a939610ee; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.producteur_films
    ADD CONSTRAINT fk_7fdc262a939610ee FOREIGN KEY (films_id) REFERENCES public.films(id) ON DELETE CASCADE;


--
-- Name: producteur_films fk_7fdc262aab9bb300; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.producteur_films
    ADD CONSTRAINT fk_7fdc262aab9bb300 FOREIGN KEY (producteur_id) REFERENCES public.producteur(id) ON DELETE CASCADE;


--
-- Name: acteur_films fk_82132ea0939610ee; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.acteur_films
    ADD CONSTRAINT fk_82132ea0939610ee FOREIGN KEY (films_id) REFERENCES public.films(id) ON DELETE CASCADE;


--
-- Name: acteur_films fk_82132ea0da6f574a; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.acteur_films
    ADD CONSTRAINT fk_82132ea0da6f574a FOREIGN KEY (acteur_id) REFERENCES public.acteur(id) ON DELETE CASCADE;


--
-- Name: users_likes_films fk_85a55a2567b3b43d; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.users_likes_films
    ADD CONSTRAINT fk_85a55a2567b3b43d FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: users_likes_films fk_85a55a25c0973ab2; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.users_likes_films
    ADD CONSTRAINT fk_85a55a25c0973ab2 FOREIGN KEY (likes_films_id) REFERENCES public.likes_films(id) ON DELETE CASCADE;


--
-- Name: films_likes_films fk_95ae839b939610ee; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.films_likes_films
    ADD CONSTRAINT fk_95ae839b939610ee FOREIGN KEY (films_id) REFERENCES public.films(id) ON DELETE CASCADE;


--
-- Name: films_likes_films fk_95ae839bc0973ab2; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.films_likes_films
    ADD CONSTRAINT fk_95ae839bc0973ab2 FOREIGN KEY (likes_films_id) REFERENCES public.likes_films(id) ON DELETE CASCADE;


--
-- Name: realisateur_films fk_af7d8d4c939610ee; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.realisateur_films
    ADD CONSTRAINT fk_af7d8d4c939610ee FOREIGN KEY (films_id) REFERENCES public.films(id) ON DELETE CASCADE;


--
-- Name: realisateur_films fk_af7d8d4cf1d8422e; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.realisateur_films
    ADD CONSTRAINT fk_af7d8d4cf1d8422e FOREIGN KEY (realisateur_id) REFERENCES public.realisateur(id) ON DELETE CASCADE;


--
-- Name: image fk_c53d045f51e8c8; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT fk_c53d045f51e8c8 FOREIGN KEY (imagefilm_id) REFERENCES public.films(id);


--
-- PostgreSQL database dump complete
--

