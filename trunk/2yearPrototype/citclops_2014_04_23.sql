--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.4
-- Dumped by pg_dump version 9.3.4
-- Started on 2014-04-23 13:20:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 176 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1981 (class 0 OID 0)
-- Dependencies: 176
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 177 (class 3079 OID 16505)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 1982 (class 0 OID 0)
-- Dependencies: 177
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 174 (class 1259 OID 17056)
-- Name: metadata; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE metadata (
    record_id integer NOT NULL,
    dataset_name character varying(32),
    observation_id character varying(40),
    date_time timestamp without time zone,
    measuring_area_type_l02 character varying(5),
    location_lat character varying(32),
    location_lon character varying(32),
    datum_coordinate_system_l10 character varying(10),
    parameters_measured_p01 character varying(32),
    abstract xml,
    platform_type_l06 character varying(10),
    device_type_l05 character varying(15),
    device_name character varying(32),
    station_name character varying(32),
    pi numeric(6,0),
    station_start_date_time timestamp without time zone,
    station_end_date_time timestamp without time zone,
    language character varying(4) DEFAULT 'en'::character varying,
    data_format_l24 character varying(10),
    data_format_version character varying(3),
    viewing_angle numeric(6,3),
    azimuth_angle numeric(6,3),
    remark character varying(32),
    cloud_fraction character varying(32),
    rain boolean,
    wind_waves character varying(32),
    surface_sd character varying(32),
    bottom boolean,
    secchi_disk_type character varying(32),
    shadow numeric(1,0),
    height numeric(4,2),
    last_update timestamp without time zone,
    data_created timestamp without time zone,
    update_count integer,
    active boolean,
    location point
);


ALTER TABLE public.metadata OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 16682)
-- Name: metadata2; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE metadata2 (
    record_id integer NOT NULL,
    dataset_name character varying(100),
    observation_id character varying(100),
    date_time character varying(100),
    measuring_area_type_l02 character varying(5),
    location_lat character varying(100),
    location_lon character varying(100),
    datum_coordinate_system_l10 character varying(100),
    parameters_measured_p01 character varying(100),
    abstract xml,
    platform_type_l06 character varying(55),
    device_type_l05 character varying(55),
    device_name character varying(100),
    station_name character varying(100),
    pi character varying(100),
    station_start_date_time character varying(100),
    station_end_date_time character varying(100),
    language character varying(100),
    data_format_l24 character varying(10),
    data_format_version character varying(3),
    viewing_angle character varying(100),
    azimuth_angle character varying(100),
    remark character varying(100),
    cloud_fraction character varying(100),
    rain character varying(100),
    wind_waves character varying(100),
    surface_sd character varying(100),
    bottom character varying(100),
    secchi_disk_type character varying(100),
    shadow character varying(100),
    height character varying(100),
    last_update character varying(100),
    data_created character varying(100),
    update_count character varying(100),
    active character varying(100),
    location character varying(100)
);


ALTER TABLE public.metadata2 OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 16680)
-- Name: metadata2_record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE metadata2_record_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metadata2_record_id_seq OWNER TO postgres;

--
-- TOC entry 1983 (class 0 OID 0)
-- Dependencies: 171
-- Name: metadata2_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE metadata2_record_id_seq OWNED BY metadata2.record_id;


--
-- TOC entry 173 (class 1259 OID 17054)
-- Name: metadata_record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE metadata_record_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metadata_record_id_seq OWNER TO postgres;

--
-- TOC entry 1984 (class 0 OID 0)
-- Dependencies: 173
-- Name: metadata_record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE metadata_record_id_seq OWNED BY metadata.record_id;


--
-- TOC entry 175 (class 1259 OID 17075)
-- Name: observation; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE observation (
    observation_id character varying(40) NOT NULL,
    observation character varying(32),
    quality_flag integer,
    last_update timestamp without time zone,
    data_created timestamp without time zone,
    update_count integer,
    active boolean,
    xml xml
);


ALTER TABLE public.observation OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 16410)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE person (
    pi character varying(32) NOT NULL,
    profile character varying(32),
    reputation numeric,
    firstname character varying(32),
    lastname character varying(32),
    email character varying(150),
    phone character varying(16),
    birthday character varying(8),
    gender character varying(1),
    city character varying(32),
    country character varying(32),
    work character varying(32),
    friends character varying(64),
    groups character varying(64),
    last_update timestamp without time zone,
    data_created timestamp without time zone,
    update_count integer,
    active boolean
);


ALTER TABLE public.person OWNER TO postgres;

--
-- TOC entry 1853 (class 2604 OID 17059)
-- Name: record_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metadata ALTER COLUMN record_id SET DEFAULT nextval('metadata_record_id_seq'::regclass);


--
-- TOC entry 1852 (class 2604 OID 16685)
-- Name: record_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metadata2 ALTER COLUMN record_id SET DEFAULT nextval('metadata2_record_id_seq'::regclass);


--
-- TOC entry 1972 (class 0 OID 17056)
-- Dependencies: 174
-- Data for Name: metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY metadata (record_id, dataset_name, observation_id, date_time, measuring_area_type_l02, location_lat, location_lon, datum_coordinate_system_l10, parameters_measured_p01, abstract, platform_type_l06, device_type_l05, device_name, station_name, pi, station_start_date_time, station_end_date_time, language, data_format_l24, data_format_version, viewing_angle, azimuth_angle, remark, cloud_fraction, rain, wind_waves, surface_sd, bottom, secchi_disk_type, shadow, height, last_update, data_created, update_count, active, location) FROM stdin;
23	Ocean colour via citclops app	418D4C334A199AE91395662110973	2014-03-24 12:55:00	Point	41.436695	2.1688595	4326:WGS84	R410	<LocationAccuracy>\n609.0</LocationAccuracy>\n<CameraParameters>\n<Antibanding>50hz</Antibanding>\n<AutoExposureLock>false</AutoExposureLock>\n<AutoWhiteBalanceLock>false</AutoWhiteBalanceLock>\n<ColorEffect>none</ColorEffect>\n<ExposureCompensation>0</ExposureCompensation>\n<FlashMode>off</FlashMode>\n<FocalLength>3.7</FocalLength>\n<FocusMode>auto</FocusMode>\n<HorizontalViewAngle>63.0</HorizontalViewAngle>\n<JpegQuality>100</JpegQuality>\n<PictureFormat>256</PictureFormat>\n<PictureSize>1280x720</PictureSize>\n<Scene>auto</Scene>\n<VerticalViewAngle>49.3</VerticalViewAngle>\n<WhiteBalance>auto</WhiteBalance>\n<Zoom>0</Zoom>\n</CameraParameters>\n	71:Human	XXX:???????	samsung GT-I9305	418D4C334A199AE9	0	2014-03-24 12:55:00	2014-03-24 12:55:00	en	 	JPG	23.000	141.000	 	Few	t	No	false-true	f	no	0	0.00	2014-04-11 12:59:00	2014-04-11 12:59:00	1	t	(41.436695,2.1688594999999999)
\.


--
-- TOC entry 1970 (class 0 OID 16682)
-- Dependencies: 172
-- Data for Name: metadata2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY metadata2 (record_id, dataset_name, observation_id, date_time, measuring_area_type_l02, location_lat, location_lon, datum_coordinate_system_l10, parameters_measured_p01, abstract, platform_type_l06, device_type_l05, device_name, station_name, pi, station_start_date_time, station_end_date_time, language, data_format_l24, data_format_version, viewing_angle, azimuth_angle, remark, cloud_fraction, rain, wind_waves, surface_sd, bottom, secchi_disk_type, shadow, height, last_update, data_created, update_count, active, location) FROM stdin;
1	Ocean colour via citclops app	889F92B2105F792E139585100210087	2014-03-26T18:00+0100	Point	40.61564847910496	0.5968021268116314	41006:WGS84	R410	<LocationAccuracy>\n8.0</LocationAccuracy>\n<CameraParameters>\n<Antibanding>50hz</Antibanding>\n<AutoExposureLock>false</AutoExposureLock>\n<AutoWhiteBalanceLock>false</AutoWhiteBalanceLock>\n<ColorEffect>none</ColorEffect>\n<ExposureCompensation>0</ExposureCompensation>\n<FlashMode>off</FlashMode>\n<FocalLength>3.7</FocalLength>\n<FocusMode>auto</FocusMode>\n<HorizontalViewAngle>63.0</HorizontalViewAngle>\n<JpegQuality>100</JpegQuality>\n<PictureFormat>256</PictureFormat>\n<PictureSize>1280x720</PictureSize>\n<Scene>auto</Scene>\n<VerticalViewAngle>49.3</VerticalViewAngle>\n<WhiteBalance>auto</WhiteBalance>\n<Zoom>0</Zoom>\n</CameraParameters>\n	71:Human	XXX:???????	samsung GT-I9300	889F92B2105F792E	889F92B2105F792E	2014-03-26T18:00+0100	2014-03-26T18:00+0100	en	RESEARCHER	JPG	889F92B2105F792E.13958510078417.jpg	5	17	138	Clear	No	No	true	1.75	false	null	null	null	null	null	null
2	Ocean colour via citclops app	889F92B2105F792E1395853223287	2014-03-26T18:00+0100	Point	40.61564847910496	0.5968021268116314	4326:WGS84	R410	<LocationAccuracy>\n8.0</LocationAccuracy>\n<CameraParameters>\n<Antibanding>50hz</Antibanding>\n<AutoExposureLock>false</AutoExposureLock>\n<AutoWhiteBalanceLock>false</AutoWhiteBalanceLock>\n<ColorEffect>none</ColorEffect>\n<ExposureCompensation>0</ExposureCompensation>\n<FlashMode>off</FlashMode>\n<FocalLength>3.7</FocalLength>\n<FocusMode>auto</FocusMode>\n<HorizontalViewAngle>63.0</HorizontalViewAngle>\n<JpegQuality>100</JpegQuality>\n<PictureFormat>256</PictureFormat>\n<PictureSize>1280x720</PictureSize>\n<Scene>auto</Scene>\n<VerticalViewAngle>49.3</VerticalViewAngle>\n<WhiteBalance>auto</WhiteBalance>\n<Zoom>0</Zoom>\n</CameraParameters>\n	71:Human	XXX:???????	samsung GT-I9300	889F92B2105F792E	889F92B2105F792E	2014-03-26T18:00+0100	2014-03-26T18:00+0100	en	RESEARCHER	JPG	889F92B2105F792E.1395853278417.jpg	5	17	138	Clear	No	No	true	1.75	false	 	 	 	 	 	 
3	Ocean colour via citclops app	889F92B2105F792E1395853223287	2014-03-26T18:00+0100	Point	40.61564847910496	0.5968021268116314	4326:WGS84	R410	<LocationAccuracy>\n8.0</LocationAccuracy>\n<CameraParameters>\n<Antibanding>50hz</Antibanding>\n<AutoExposureLock>false</AutoExposureLock>\n<AutoWhiteBalanceLock>false</AutoWhiteBalanceLock>\n<ColorEffect>none</ColorEffect>\n<ExposureCompensation>0</ExposureCompensation>\n<FlashMode>off</FlashMode>\n<FocalLength>3.7</FocalLength>\n<FocusMode>auto</FocusMode>\n<HorizontalViewAngle>63.0</HorizontalViewAngle>\n<JpegQuality>100</JpegQuality>\n<PictureFormat>256</PictureFormat>\n<PictureSize>1280x720</PictureSize>\n<Scene>auto</Scene>\n<VerticalViewAngle>49.3</VerticalViewAngle>\n<WhiteBalance>auto</WhiteBalance>\n<Zoom>0</Zoom>\n</CameraParameters>\n	71:Human	XXX:???????	samsung GT-I9300	889F92B2105F792E	889F92B2105F792E	2014-03-26T18:00+0100	2014-03-26T18:00+0100	en	RESEARCHER	JPG	889F92B2105F792E.1395853278417.jpg	5	17	138	Clear	No	No	true	1.75	false	 	 	 	 	 	 
4	Ocean colour via citclops app	889F92B2105F792E1395853223287	2014-03-26T18:00+0100	Point	40.61564847910496	0.5968021268116314	4326:WGS84	R410	<LocationAccuracy>\n8.0</LocationAccuracy>\n<CameraParameters>\n<Antibanding>50hz</Antibanding>\n<AutoExposureLock>false</AutoExposureLock>\n<AutoWhiteBalanceLock>false</AutoWhiteBalanceLock>\n<ColorEffect>none</ColorEffect>\n<ExposureCompensation>0</ExposureCompensation>\n<FlashMode>off</FlashMode>\n<FocalLength>3.7</FocalLength>\n<FocusMode>auto</FocusMode>\n<HorizontalViewAngle>63.0</HorizontalViewAngle>\n<JpegQuality>100</JpegQuality>\n<PictureFormat>256</PictureFormat>\n<PictureSize>1280x720</PictureSize>\n<Scene>auto</Scene>\n<VerticalViewAngle>49.3</VerticalViewAngle>\n<WhiteBalance>auto</WhiteBalance>\n<Zoom>0</Zoom>\n</CameraParameters>\n	71:Human	XXX:???????	samsung GT-I9300	889F92B2105F792E	889F92B2105F792E	2014-03-26T18:00+0100	2014-03-26T18:00+0100	en	RESEARCHER	JPG	889F92B2105F792E.1395853278417.jpg	5	17	138	Clear	No	No	true	1.75	false	 	 	 	 	 	 
5	Ocean colour via citclops app	889F92B2105F792E1395853223287	2014-03-26T18:00+0100	Point	40.61564847910496	0.5968021268116314	4326:WGS84	R410	<LocationAccuracy>\n8.0</LocationAccuracy>\n<CameraParameters>\n<Antibanding>50hz</Antibanding>\n<AutoExposureLock>false</AutoExposureLock>\n<AutoWhiteBalanceLock>false</AutoWhiteBalanceLock>\n<ColorEffect>none</ColorEffect>\n<ExposureCompensation>0</ExposureCompensation>\n<FlashMode>off</FlashMode>\n<FocalLength>3.7</FocalLength>\n<FocusMode>auto</FocusMode>\n<HorizontalViewAngle>63.0</HorizontalViewAngle>\n<JpegQuality>100</JpegQuality>\n<PictureFormat>256</PictureFormat>\n<PictureSize>1280x720</PictureSize>\n<Scene>auto</Scene>\n<VerticalViewAngle>49.3</VerticalViewAngle>\n<WhiteBalance>auto</WhiteBalance>\n<Zoom>0</Zoom>\n</CameraParameters>\n	71:Human	XXX:???????	samsung GT-I9300	889F92B2105F792E	889F92B2105F792E	2014-03-26T18:00+0100	2014-03-26T18:00+0100	en	RESEARCHER	JPG	889F92B2105F792E.1395853278417.jpg	5	17	138	Clear	No	No	true	1.75	false	 	 	 	 	 	 
6	Ocean colour via citclops app	889F92B2105F792E1395853223287	2014-03-26T18:00+0100	Point	40.61564847910496	0.5968021268116314	4326:WGS84	R410	<LocationAccuracy>\n8.0</LocationAccuracy>\n<CameraParameters>\n<Antibanding>50hz</Antibanding>\n<AutoExposureLock>false</AutoExposureLock>\n<AutoWhiteBalanceLock>false</AutoWhiteBalanceLock>\n<ColorEffect>none</ColorEffect>\n<ExposureCompensation>0</ExposureCompensation>\n<FlashMode>off</FlashMode>\n<FocalLength>3.7</FocalLength>\n<FocusMode>auto</FocusMode>\n<HorizontalViewAngle>63.0</HorizontalViewAngle>\n<JpegQuality>100</JpegQuality>\n<PictureFormat>256</PictureFormat>\n<PictureSize>1280x720</PictureSize>\n<Scene>auto</Scene>\n<VerticalViewAngle>49.3</VerticalViewAngle>\n<WhiteBalance>auto</WhiteBalance>\n<Zoom>0</Zoom>\n</CameraParameters>\n	71:Human	XXX:???????	samsung GT-I9300	889F92B2105F792E	889F92B2105F792E	2014-03-26T18:00+0100	2014-03-26T18:00+0100	en	RESEARCHER	JPG	889F92B2105F792E.1395853278417.jpg	5	17	138	Clear	No	No	true	1.75	false	 	 	 	 	 	 
7	Ocean colour via citclops app	418D4C334A199AE91395660542832	2014-03-24T12:29+0100	Point	41.4363013	2.1688114	4326:WGS84	R410	<LocationAccuracy>\n678.0</LocationAccuracy>\n<CameraParameters>\n<Antibanding>50hz</Antibanding>\n<AutoExposureLock>false</AutoExposureLock>\n<AutoWhiteBalanceLock>false</AutoWhiteBalanceLock>\n<ColorEffect>none</ColorEffect>\n<ExposureCompensation>0</ExposureCompensation>\n<FlashMode>off</FlashMode>\n<FocalLength>3.7</FocalLength>\n<FocusMode>auto</FocusMode>\n<HorizontalViewAngle>63.0</HorizontalViewAngle>\n<JpegQuality>100</JpegQuality>\n<PictureFormat>256</PictureFormat>\n<PictureSize>1280x720</PictureSize>\n<Scene>auto</Scene>\n<VerticalViewAngle>49.3</VerticalViewAngle>\n<WhiteBalance>auto</WhiteBalance>\n<Zoom>0</Zoom>\n</CameraParameters>\n	71:Human	XXX:???????	samsung GT-I9305	418D4C334A199AE9	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 1985 (class 0 OID 0)
-- Dependencies: 171
-- Name: metadata2_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('metadata2_record_id_seq', 7, true);


--
-- TOC entry 1986 (class 0 OID 0)
-- Dependencies: 173
-- Name: metadata_record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('metadata_record_id_seq', 26, true);


--
-- TOC entry 1973 (class 0 OID 17075)
-- Dependencies: 175
-- Data for Name: observation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY observation (observation_id, observation, quality_flag, last_update, data_created, update_count, active, xml) FROM stdin;
418D4C334A199AE91395662110973	3	\N	2014-04-11 12:59:00	2014-04-11 12:59:00	\N	\N	\N
\.


--
-- TOC entry 1968 (class 0 OID 16410)
-- Dependencies: 170
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY person (pi, profile, reputation, firstname, lastname, email, phone, birthday, gender, city, country, work, friends, groups, last_update, data_created, update_count, active) FROM stdin;
\.


--
-- TOC entry 1858 (class 2606 OID 17065)
-- Name: metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metadata
    ADD CONSTRAINT metadata_pkey PRIMARY KEY (record_id);


--
-- TOC entry 1860 (class 2606 OID 17082)
-- Name: observation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY observation
    ADD CONSTRAINT observation_pkey PRIMARY KEY (observation_id);


--
-- TOC entry 1856 (class 2606 OID 16417)
-- Name: person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (pi);


--
-- TOC entry 1980 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-04-23 13:20:18

--
-- PostgreSQL database dump complete
--

