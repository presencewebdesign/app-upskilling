--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2 (Debian 17.2-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO pguser;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO pguser;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: pguser
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_activity_id_seq OWNER TO pguser;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pguser
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO pguser;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO pguser;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO pguser;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO pguser;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO pguser;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: pguser
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_fields_id_seq OWNER TO pguser;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pguser
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO pguser;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO pguser;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO pguser;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO pguser;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO pguser;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: pguser
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_notifications_id_seq OWNER TO pguser;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pguser
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO pguser;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO pguser;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO pguser;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: pguser
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_permissions_id_seq OWNER TO pguser;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pguser
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO pguser;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO pguser;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: pguser
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_presets_id_seq OWNER TO pguser;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pguser
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO pguser;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: pguser
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_relations_id_seq OWNER TO pguser;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pguser
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO pguser;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: pguser
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_revisions_id_seq OWNER TO pguser;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pguser
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO pguser;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO pguser;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json
);


ALTER TABLE public.directus_settings OWNER TO pguser;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: pguser
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_settings_id_seq OWNER TO pguser;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pguser
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO pguser;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO pguser;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json
);


ALTER TABLE public.directus_users OWNER TO pguser;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO pguser;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json,
    was_active_before_deprecation boolean DEFAULT false NOT NULL,
    migrated_flow uuid
);


ALTER TABLE public.directus_webhooks OWNER TO pguser;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: pguser
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directus_webhooks_id_seq OWNER TO pguser;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pguser
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.messages (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    content character varying(255),
    "to" uuid,
    subject character varying(255)
);


ALTER TABLE public.messages OWNER TO pguser;

--
-- Name: sjr; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.sjr (
    id uuid NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    machine_name character varying(255),
    name character varying(255)
);


ALTER TABLE public.sjr OWNER TO pguser;

--
-- Name: sjr_directus_roles; Type: TABLE; Schema: public; Owner: pguser
--

CREATE TABLE public.sjr_directus_roles (
    id integer NOT NULL,
    sjr_id uuid,
    directus_roles_id uuid
);


ALTER TABLE public.sjr_directus_roles OWNER TO pguser;

--
-- Name: sjr_directus_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: pguser
--

CREATE SEQUENCE public.sjr_directus_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sjr_directus_roles_id_seq OWNER TO pguser;

--
-- Name: sjr_directus_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pguser
--

ALTER SEQUENCE public.sjr_directus_roles_id_seq OWNED BY public.sjr_directus_roles.id;


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: sjr_directus_roles id; Type: DEFAULT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.sjr_directus_roles ALTER COLUMN id SET DEFAULT nextval('public.sjr_directus_roles_id_seq'::regclass);


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
6406a072-d86a-4d2d-bc00-04c2eb4f6c30	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
eeccfadf-8bd5-46f7-a1a2-fdc1babeaeff	ea221134-dcd8-4598-9ae2-d84a2a044a03	\N	05356158-032f-4864-bf26-0041eea9b895	\N
19c8702c-f9f1-417a-a858-043db1a99556	\N	2d1c7579-a552-40c3-8951-5457699ce81a	9ce012a6-6ddd-411f-9cbc-42877fbc51f7	1
b796c415-047e-46d1-a7fc-63bcef5d0562	\N	313c5ea6-f636-46c6-932d-426e72f7c23f	9ce012a6-6ddd-411f-9cbc-42877fbc51f7	1
6fde25df-ff9c-45a5-b026-6db2b6db4953	\N	fc595e66-7a89-4db0-a272-77c75646d18e	9ce012a6-6ddd-411f-9cbc-42877fbc51f7	1
d88ecd3f-5b37-409c-8247-adde50dd746b	35ee142b-a2c5-4153-ba00-288c4b4ca386	\N	e23cf42d-1cb2-4784-9971-61ec0bd105e2	1
511d0f2d-2049-4711-8b28-266464a80747	a1dd6fde-d3ed-4677-bdcb-36adefb46283	\N	e23cf42d-1cb2-4784-9971-61ec0bd105e2	1
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-24 10:29:26.749+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	88d552a3-0515-443b-9e23-109ddacd9d0a	http://localhost:8055
2	login	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-24 11:22:34.461+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	88d552a3-0515-443b-9e23-109ddacd9d0a	http://localhost:8055
3	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-24 13:59:20.752+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	9ce012a6-6ddd-411f-9cbc-42877fbc51f7	http://localhost:8055
4	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-24 13:59:20.76+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_access	19c8702c-f9f1-417a-a858-043db1a99556	http://localhost:8055
5	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-24 13:59:20.768+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:8055
6	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-24 13:59:52.611+00	127.0.0.1	curl/8.7.1	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	\N
7	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-24 14:48:24.259+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
8	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-24 14:49:54.152+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
9	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-24 14:50:31.096+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
10	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-24 14:50:45.572+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
11	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-24 14:54:43.33+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
12	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-24 14:54:45.497+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
13	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-24 15:19:22.954+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
14	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-24 15:19:27.732+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
15	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-24 15:20:59.853+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
16	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-27 15:39:18.44+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
17	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-27 15:41:25.95+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
18	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-27 15:42:11.936+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
19	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-27 15:47:35.171+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
20	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-27 15:53:51.132+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
21	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-27 15:55:11.875+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
22	login	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 15:56:15.522+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	88d552a3-0515-443b-9e23-109ddacd9d0a	http://localhost:8055
23	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 15:57:49.236+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_access	b796c415-047e-46d1-a7fc-63bcef5d0562	http://localhost:8055
24	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 15:57:49.246+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	313c5ea6-f636-46c6-932d-426e72f7c23f	http://localhost:8055
25	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:02:11.334+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_access	6fde25df-ff9c-45a5-b026-6db2b6db4953	http://localhost:8055
26	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:02:11.344+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	fc595e66-7a89-4db0-a272-77c75646d18e	http://localhost:8055
27	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:04:51.006+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	1	http://localhost:8055
28	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:04:51.015+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	2	http://localhost:8055
29	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:04:51.024+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	3	http://localhost:8055
30	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:04:51.033+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	4	http://localhost:8055
31	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:04:51.041+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	messages	http://localhost:8055
32	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:05:34.992+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	5	http://localhost:8055
33	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:11:03.438+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	6	http://localhost:8055
34	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:12:09.265+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	6	http://localhost:8055
35	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:12:52.106+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	3	http://localhost:8055
36	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:13:47.698+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	messages	http://localhost:8055
37	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:16:29.88+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	7	http://localhost:8055
38	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:16:51.648+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	7	http://localhost:8055
39	delete	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:17:06.85+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	6	http://localhost:8055
40	delete	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:17:24.242+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	7	http://localhost:8055
41	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:17:53.491+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	8	http://localhost:8055
42	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:18:14.293+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	8	http://localhost:8055
43	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:19:43.516+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	8	http://localhost:8055
44	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:19:59.223+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	messages	7ff1570b-0f6c-4d6e-9504-d4ec9d322744	http://localhost:8055
45	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:20:20.572+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	messages	9f31fcb9-161b-46bf-b47e-5214d0b8bba3	http://localhost:8055
46	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:20:26.721+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	messages	7ff1570b-0f6c-4d6e-9504-d4ec9d322744	http://localhost:8055
47	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-27 16:26:36.19+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
48	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:28:04.081+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	1	http://localhost:8055
49	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:28:04.092+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	9ce012a6-6ddd-411f-9cbc-42877fbc51f7	http://localhost:8055
50	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:34:26.515+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	1	http://localhost:8055
51	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:34:26.527+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	9ce012a6-6ddd-411f-9cbc-42877fbc51f7	http://localhost:8055
52	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:34:42.596+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	8	http://localhost:8055
53	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:36:47.685+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	9	http://localhost:8055
54	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:37:06.323+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	messages	7ff1570b-0f6c-4d6e-9504-d4ec9d322744	http://localhost:8055
55	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-27 16:37:15.597+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	messages	9f31fcb9-161b-46bf-b47e-5214d0b8bba3	http://localhost:8055
56	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-27 16:50:19.446+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
57	login	313c5ea6-f636-46c6-932d-426e72f7c23f	2025-01-27 16:59:47.503+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	313c5ea6-f636-46c6-932d-426e72f7c23f	http://localhost:5173
58	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-27 17:07:19.466+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
59	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-28 11:57:56.354+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
60	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-28 12:37:11.707+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
61	login	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:53:26.358+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	88d552a3-0515-443b-9e23-109ddacd9d0a	http://localhost:8055
62	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:54:50.448+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	10	http://localhost:8055
63	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:54:50.464+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	11	http://localhost:8055
64	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:54:50.474+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	12	http://localhost:8055
65	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:54:50.481+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	sjr	http://localhost:8055
66	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:55:23.936+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	13	http://localhost:8055
67	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:55:41.889+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	14	http://localhost:8055
68	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:55:46.546+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	10	http://localhost:8055
69	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:55:46.566+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	11	http://localhost:8055
70	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:55:46.584+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	12	http://localhost:8055
71	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:55:46.601+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	14	http://localhost:8055
72	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:55:46.619+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	13	http://localhost:8055
73	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:56:56.84+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	sjr	http://localhost:8055
74	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:57:17.194+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	15	http://localhost:8055
75	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:57:17.203+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	16	http://localhost:8055
76	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:57:17.213+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	17	http://localhost:8055
77	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:57:17.22+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	sjr_role	http://localhost:8055
78	delete	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:58:07.385+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	sjr_role	http://localhost:8055
79	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:58:43.465+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	18	http://localhost:8055
80	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:58:43.587+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	19	http://localhost:8055
81	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:58:43.595+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_collections	sjr_directus_roles	http://localhost:8055
82	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:58:43.669+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	20	http://localhost:8055
83	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:58:43.775+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_fields	21	http://localhost:8055
84	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 12:59:21.246+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_roles	35ee142b-a2c5-4153-ba00-288c4b4ca386	http://localhost:8055
85	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:02:52.65+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:8055
86	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:02:52.663+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	fc595e66-7a89-4db0-a272-77c75646d18e	http://localhost:8055
87	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:02:52.678+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	2	http://localhost:8055
88	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:02:52.683+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	3	http://localhost:8055
89	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:02:52.688+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	e23cf42d-1cb2-4784-9971-61ec0bd105e2	http://localhost:8055
90	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:02:52.693+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_access	d88ecd3f-5b37-409c-8247-adde50dd746b	http://localhost:8055
91	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:02:52.706+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_roles	35ee142b-a2c5-4153-ba00-288c4b4ca386	http://localhost:8055
92	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:03:07.088+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_roles	a1dd6fde-d3ed-4677-bdcb-36adefb46283	http://localhost:8055
93	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:03:47.543+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_users	313c5ea6-f636-46c6-932d-426e72f7c23f	http://localhost:8055
94	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:03:47.568+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_access	511d0f2d-2049-4711-8b28-266464a80747	http://localhost:8055
95	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:03:47.581+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_roles	a1dd6fde-d3ed-4677-bdcb-36adefb46283	http://localhost:8055
96	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:04:24.941+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	sjr_directus_roles	1	http://localhost:8055
97	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:04:24.951+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	sjr_directus_roles	2	http://localhost:8055
98	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:04:24.959+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	sjr	05f3500f-8741-46cf-9d50-36c28706e33a	http://localhost:8055
99	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:04:44.468+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	sjr_directus_roles	3	http://localhost:8055
100	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:04:44.475+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	sjr	e1d2d05a-8787-404d-946f-7192c5292b10	http://localhost:8055
101	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:06:43.579+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	2	http://localhost:8055
102	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:06:43.584+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	3	http://localhost:8055
103	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:06:43.588+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	e23cf42d-1cb2-4784-9971-61ec0bd105e2	http://localhost:8055
104	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-28 13:26:07.16+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
105	login	313c5ea6-f636-46c6-932d-426e72f7c23f	2025-01-28 13:26:22.212+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	directus_users	313c5ea6-f636-46c6-932d-426e72f7c23f	http://localhost:5173
106	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:27:19.977+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	2	http://localhost:8055
107	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:27:19.981+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	e23cf42d-1cb2-4784-9971-61ec0bd105e2	http://localhost:8055
108	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:28:40.357+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	2	http://localhost:8055
109	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:28:40.363+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	e23cf42d-1cb2-4784-9971-61ec0bd105e2	http://localhost:8055
110	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:28:51.661+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	2	http://localhost:8055
111	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:28:51.667+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	e23cf42d-1cb2-4784-9971-61ec0bd105e2	http://localhost:8055
112	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-28 13:45:19.618+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
113	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:46:02.72+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	2	http://localhost:8055
114	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:46:02.727+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	e23cf42d-1cb2-4784-9971-61ec0bd105e2	http://localhost:8055
115	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:47:07.774+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	2	http://localhost:8055
116	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:47:07.779+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	e23cf42d-1cb2-4784-9971-61ec0bd105e2	http://localhost:8055
117	create	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:48:00.124+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	4	http://localhost:8055
118	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:48:00.128+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	e23cf42d-1cb2-4784-9971-61ec0bd105e2	http://localhost:8055
119	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:49:46.539+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	2	http://localhost:8055
120	delete	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:49:46.548+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_permissions	4	http://localhost:8055
121	update	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 13:49:46.55+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	directus_policies	e23cf42d-1cb2-4784-9971-61ec0bd105e2	http://localhost:8055
122	login	313c5ea6-f636-46c6-932d-426e72f7c23f	2025-01-28 13:50:09.588+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	directus_users	313c5ea6-f636-46c6-932d-426e72f7c23f	http://localhost:5173
123	login	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-28 13:52:13.625+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	http://localhost:5173
124	login	313c5ea6-f636-46c6-932d-426e72f7c23f	2025-01-28 13:52:27.626+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	directus_users	313c5ea6-f636-46c6-932d-426e72f7c23f	http://localhost:5173
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
messages	\N	\N	\N	f	f	\N	status	t	archived	draft	\N	all	#2FBAB6	\N	\N	\N	open	\N	f
sjr	rule	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
sjr_directus_roles	import_export	\N	\N	t	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
1	messages	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
2	messages	status	\N	select-dropdown	{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]}	labels	{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]}	f	f	2	full	\N	\N	\N	f	\N	\N	\N
4	messages	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	4	half	\N	\N	\N	f	\N	\N	\N
5	messages	content	\N	input	{"placeholder":"This is a test message"}	\N	\N	f	f	5	full	\N	\N	\N	t	\N	\N	\N
3	messages	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	f	3	half	\N	\N	\N	f	\N	\N	\N
8	messages	to	m2o	select-dropdown-m2o	{"enableCreate":false}	\N	\N	f	f	6	full	\N	\N	\N	t	\N	\N	\N
9	messages	subject	\N	input	{"placeholder":"The subject of the message"}	\N	\N	f	f	7	full	\N	\N	\N	t	\N	\N	\N
10	sjr	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
11	sjr	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
12	sjr	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
14	sjr	name	\N	input	{"placeholder":"Human readable name for the rule"}	\N	\N	f	f	4	full	\N	\N	\N	t	\N	\N	\N
13	sjr	machine_name	\N	input	{"placeholder":"Snake Case Name for the rule"}	\N	\N	f	f	5	full	\N	\N	\N	t	\N	\N	\N
18	sjr	roles	m2m	list-m2m	{"enableCreate":false}	\N	\N	f	f	6	full	\N	\N	\N	t	\N	\N	\N
19	sjr_directus_roles	id	\N	\N	\N	\N	\N	f	t	1	full	\N	\N	\N	f	\N	\N	\N
20	sjr_directus_roles	sjr_id	\N	\N	\N	\N	\N	f	t	2	full	\N	\N	\N	f	\N	\N	\N
21	sjr_directus_roles	directus_roles_id	\N	\N	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2025-01-24 10:28:27.121758+00
20201029A	Remove System Relations	2025-01-24 10:28:27.134064+00
20201029B	Remove System Collections	2025-01-24 10:28:27.14164+00
20201029C	Remove System Fields	2025-01-24 10:28:27.148811+00
20201105A	Add Cascade System Relations	2025-01-24 10:28:27.17827+00
20201105B	Change Webhook URL Type	2025-01-24 10:28:27.183347+00
20210225A	Add Relations Sort Field	2025-01-24 10:28:27.187112+00
20210304A	Remove Locked Fields	2025-01-24 10:28:27.188465+00
20210312A	Webhooks Collections Text	2025-01-24 10:28:27.192606+00
20210331A	Add Refresh Interval	2025-01-24 10:28:27.194076+00
20210415A	Make Filesize Nullable	2025-01-24 10:28:27.198222+00
20210416A	Add Collections Accountability	2025-01-24 10:28:27.200194+00
20210422A	Remove Files Interface	2025-01-24 10:28:27.201313+00
20210506A	Rename Interfaces	2025-01-24 10:28:27.217556+00
20210510A	Restructure Relations	2025-01-24 10:28:27.225292+00
20210518A	Add Foreign Key Constraints	2025-01-24 10:28:27.229681+00
20210519A	Add System Fk Triggers	2025-01-24 10:28:27.240862+00
20210521A	Add Collections Icon Color	2025-01-24 10:28:27.242063+00
20210525A	Add Insights	2025-01-24 10:28:27.246635+00
20210608A	Add Deep Clone Config	2025-01-24 10:28:27.247724+00
20210626A	Change Filesize Bigint	2025-01-24 10:28:27.252663+00
20210716A	Add Conditions to Fields	2025-01-24 10:28:27.253766+00
20210721A	Add Default Folder	2025-01-24 10:28:27.259663+00
20210802A	Replace Groups	2025-01-24 10:28:27.268297+00
20210803A	Add Required to Fields	2025-01-24 10:28:27.269906+00
20210805A	Update Groups	2025-01-24 10:28:27.272458+00
20210805B	Change Image Metadata Structure	2025-01-24 10:28:27.27525+00
20210811A	Add Geometry Config	2025-01-24 10:28:27.276447+00
20210831A	Remove Limit Column	2025-01-24 10:28:27.277522+00
20210903A	Add Auth Provider	2025-01-24 10:28:27.283558+00
20210907A	Webhooks Collections Not Null	2025-01-24 10:28:27.28738+00
20210910A	Move Module Setup	2025-01-24 10:28:27.289017+00
20210920A	Webhooks URL Not Null	2025-01-24 10:28:27.292483+00
20210924A	Add Collection Organization	2025-01-24 10:28:27.294141+00
20210927A	Replace Fields Group	2025-01-24 10:28:27.29769+00
20210927B	Replace M2M Interface	2025-01-24 10:28:27.298696+00
20210929A	Rename Login Action	2025-01-24 10:28:27.299647+00
20211007A	Update Presets	2025-01-24 10:28:27.302873+00
20211009A	Add Auth Data	2025-01-24 10:28:27.303863+00
20211016A	Add Webhook Headers	2025-01-24 10:28:27.304825+00
20211103A	Set Unique to User Token	2025-01-24 10:28:27.306106+00
20211103B	Update Special Geometry	2025-01-24 10:28:27.307128+00
20211104A	Remove Collections Listing	2025-01-24 10:28:27.30809+00
20211118A	Add Notifications	2025-01-24 10:28:27.311859+00
20211211A	Add Shares	2025-01-24 10:28:27.317109+00
20211230A	Add Project Descriptor	2025-01-24 10:28:27.318111+00
20220303A	Remove Default Project Color	2025-01-24 10:28:27.321738+00
20220308A	Add Bookmark Icon and Color	2025-01-24 10:28:27.322799+00
20220314A	Add Translation Strings	2025-01-24 10:28:27.323747+00
20220322A	Rename Field Typecast Flags	2025-01-24 10:28:27.326164+00
20220323A	Add Field Validation	2025-01-24 10:28:27.327565+00
20220325A	Fix Typecast Flags	2025-01-24 10:28:27.329905+00
20220325B	Add Default Language	2025-01-24 10:28:27.333853+00
20220402A	Remove Default Value Panel Icon	2025-01-24 10:28:27.337134+00
20220429A	Add Flows	2025-01-24 10:28:27.34546+00
20220429B	Add Color to Insights Icon	2025-01-24 10:28:27.346653+00
20220429C	Drop Non Null From IP of Activity	2025-01-24 10:28:27.347595+00
20220429D	Drop Non Null From Sender of Notifications	2025-01-24 10:28:27.348538+00
20220614A	Rename Hook Trigger to Event	2025-01-24 10:28:27.349429+00
20220801A	Update Notifications Timestamp Column	2025-01-24 10:28:27.353004+00
20220802A	Add Custom Aspect Ratios	2025-01-24 10:28:27.354065+00
20220826A	Add Origin to Accountability	2025-01-24 10:28:27.355435+00
20230401A	Update Material Icons	2025-01-24 10:28:27.35925+00
20230525A	Add Preview Settings	2025-01-24 10:28:27.360198+00
20230526A	Migrate Translation Strings	2025-01-24 10:28:27.363648+00
20230721A	Require Shares Fields	2025-01-24 10:28:27.366849+00
20230823A	Add Content Versioning	2025-01-24 10:28:27.372096+00
20230927A	Themes	2025-01-24 10:28:27.378306+00
20231009A	Update CSV Fields to Text	2025-01-24 10:28:27.380862+00
20231009B	Update Panel Options	2025-01-24 10:28:27.381912+00
20231010A	Add Extensions	2025-01-24 10:28:27.383534+00
20231215A	Add Focalpoints	2025-01-24 10:28:27.38456+00
20240122A	Add Report URL Fields	2025-01-24 10:28:27.38558+00
20240204A	Marketplace	2025-01-24 10:28:27.393831+00
20240305A	Change Useragent Type	2025-01-24 10:28:27.398408+00
20240311A	Deprecate Webhooks	2025-01-24 10:28:27.403506+00
20240422A	Public Registration	2025-01-24 10:28:27.405398+00
20240515A	Add Session Window	2025-01-24 10:28:27.406385+00
20240701A	Add Tus Data	2025-01-24 10:28:27.407396+00
20240716A	Update Files Date Fields	2025-01-24 10:28:27.410725+00
20240806A	Permissions Policies	2025-01-24 10:28:27.426516+00
20240817A	Update Icon Fields Length	2025-01-24 10:28:27.437814+00
20240909A	Separate Comments	2025-01-24 10:28:27.440956+00
20240909B	Consolidate Content Versioning	2025-01-24 10:28:27.442039+00
20240924A	Migrate Legacy Comments	2025-01-24 10:28:27.444226+00
20240924B	Populate Versioning Deltas	2025-01-24 10:28:27.447032+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
1	messages	read	{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]}	\N	\N	*	9ce012a6-6ddd-411f-9cbc-42877fbc51f7
3	messages	read	{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]}	\N	\N	id,status,date_created,date_updated,content,subject,to	e23cf42d-1cb2-4784-9971-61ec0bd105e2
2	sjr	read	{"_and":[{"roles":{"directus_roles_id":{"_eq":"$CURRENT_ROLE"}}}]}	\N	\N	*	e23cf42d-1cb2-4784-9971-61ec0bd105e2
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
05356158-032f-4864-bf26-0041eea9b895	Administrator	verified	$t:admin_description	\N	f	t	t
9ce012a6-6ddd-411f-9cbc-42877fbc51f7	App User	badge	Users of the app	\N	f	f	t
e23cf42d-1cb2-4784-9971-61ec0bd105e2	User Group Access	badge	\N	\N	f	f	t
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	88d552a3-0515-443b-9e23-109ddacd9d0a	\N	messages	\N	\N	{"tabular":{"fields":["subject","content","date_created","status","to"]}}	{"tabular":{"widths":{}}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
2	messages	to	directus_users	\N	\N	\N	\N	\N	nullify
3	sjr_directus_roles	directus_roles_id	directus_roles	\N	\N	\N	sjr_id	\N	nullify
4	sjr_directus_roles	sjr_id	sjr	roles	\N	\N	directus_roles_id	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	3	directus_policies	9ce012a6-6ddd-411f-9cbc-42877fbc51f7	{"name":"App User","description":"Users of the app","app_access":true}	{"name":"App User","description":"Users of the app","app_access":true}	2	\N
3	5	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	{"first_name":"Charlie","last_name":"Jacques","email":"charlie@test.com","password":"**********","policies":{"create":[{"policy":{"name":"App User","description":"Users of the app","app_access":true},"sort":1}],"update":[],"delete":[]}}	{"first_name":"Charlie","last_name":"Jacques","email":"charlie@test.com","password":"**********","policies":{"create":[{"policy":{"name":"App User","description":"Users of the app","app_access":true},"sort":1}],"update":[],"delete":[]}}	\N	\N
2	4	directus_access	19c8702c-f9f1-417a-a858-043db1a99556	{"policy":{"name":"App User","description":"Users of the app","app_access":true},"sort":1,"user":"2d1c7579-a552-40c3-8951-5457699ce81a"}	{"policy":{"name":"App User","description":"Users of the app","app_access":true},"sort":1,"user":"2d1c7579-a552-40c3-8951-5457699ce81a"}	3	\N
5	24	directus_users	313c5ea6-f636-46c6-932d-426e72f7c23f	{"first_name":"Testing","last_name":"Full-Permissions","email":"full-permissions@test.com","password":"**********","policies":{"create":[{"user":"+","policy":{"id":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7"},"sort":1}],"update":[],"delete":[]}}	{"first_name":"Testing","last_name":"Full-Permissions","email":"full-permissions@test.com","password":"**********","policies":{"create":[{"user":"+","policy":{"id":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7"},"sort":1}],"update":[],"delete":[]}}	\N	\N
4	23	directus_access	b796c415-047e-46d1-a7fc-63bcef5d0562	{"user":"313c5ea6-f636-46c6-932d-426e72f7c23f","policy":{"id":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7"},"sort":1}	{"user":"313c5ea6-f636-46c6-932d-426e72f7c23f","policy":{"id":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7"},"sort":1}	5	\N
7	26	directus_users	fc595e66-7a89-4db0-a272-77c75646d18e	{"first_name":"Testing","last_name":"Limited-Permissions","email":"limited-permissions@test.com","password":"**********","policies":{"create":[{"user":"+","policy":{"id":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7"},"sort":1}],"update":[],"delete":[]}}	{"first_name":"Testing","last_name":"Limited-Permissions","email":"limited-permissions@test.com","password":"**********","policies":{"create":[{"user":"+","policy":{"id":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7"},"sort":1}],"update":[],"delete":[]}}	\N	\N
6	25	directus_access	6fde25df-ff9c-45a5-b026-6db2b6db4953	{"user":"fc595e66-7a89-4db0-a272-77c75646d18e","policy":{"id":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7"},"sort":1}	{"user":"fc595e66-7a89-4db0-a272-77c75646d18e","policy":{"id":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7"},"sort":1}	7	\N
8	27	directus_fields	1	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"messages"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"messages"}	\N	\N
9	28	directus_fields	2	{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"messages"}	{"sort":2,"width":"full","options":{"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)"}]},"interface":"select-dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"text":"$t:published","value":"published","color":"var(--theme--primary)","foreground":"var(--theme--primary)","background":"var(--theme--primary-background)"},{"text":"$t:draft","value":"draft","color":"var(--theme--foreground)","foreground":"var(--theme--foreground)","background":"var(--theme--background-normal)"},{"text":"$t:archived","value":"archived","color":"var(--theme--warning)","foreground":"var(--theme--warning)","background":"var(--theme--warning-background)"}]},"field":"status","collection":"messages"}	\N	\N
10	29	directus_fields	3	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"messages"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"messages"}	\N	\N
11	30	directus_fields	4	{"sort":4,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"messages"}	{"sort":4,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"messages"}	\N	\N
12	31	directus_collections	messages	{"archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"messages"}	{"archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"messages"}	\N	\N
13	32	directus_fields	5	{"sort":5,"interface":"input","special":null,"required":true,"options":{"placeholder":"This is a test message"},"collection":"messages","field":"content"}	{"sort":5,"interface":"input","special":null,"required":true,"options":{"placeholder":"This is a test message"},"collection":"messages","field":"content"}	\N	\N
14	33	directus_fields	6	{"sort":6,"interface":"input","special":["user-created","user-updated"],"required":true,"hidden":false,"display":null,"validation":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"conditions":null,"collection":"messages","field":"to"}	{"sort":6,"interface":"input","special":["user-created","user-updated"],"required":true,"hidden":false,"display":null,"validation":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"conditions":null,"collection":"messages","field":"to"}	\N	\N
15	34	directus_fields	6	{"id":6,"collection":"messages","field":"to","special":["user-created","user-updated"],"interface":"input","options":null,"display":"raw","display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation_message":null}	{"collection":"messages","field":"to","interface":"input","display":"raw"}	\N	\N
16	35	directus_fields	3	{"id":3,"collection":"messages","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":false,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"messages","field":"date_created","hidden":false}	\N	\N
17	36	directus_collections	messages	{"collection":"messages","icon":null,"note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":"status","archive_app_filter":true,"archive_value":"archived","unarchive_value":"draft","sort_field":null,"accountability":"all","color":"#2FBAB6","item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"color":"#2FBAB6"}	\N	\N
18	37	directus_fields	7	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"enableCreate":false,"filter":{"_and":[{"role":{"_eq":null}}]}},"collection":"messages","field":"user_to"}	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"enableCreate":false,"filter":{"_and":[{"role":{"_eq":null}}]}},"collection":"messages","field":"user_to"}	\N	\N
19	38	directus_fields	7	{"id":7,"collection":"messages","field":"user_to","special":["m2o"],"interface":"select-dropdown-m2o","options":{"enableCreate":false,"filter":null},"display":"user","display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"messages","field":"user_to","options":{"enableCreate":false,"filter":null},"display":"user"}	\N	\N
20	41	directus_fields	8	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"enableCreate":false},"collection":"messages","field":"to"}	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"enableCreate":false},"collection":"messages","field":"to"}	\N	\N
21	42	directus_fields	8	{"id":8,"collection":"messages","field":"to","special":["m2o"],"interface":"select-dropdown-m2o","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation_message":null}	{"collection":"messages","field":"to","validation":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]}}	\N	\N
22	43	directus_fields	8	{"id":8,"collection":"messages","field":"to","special":["m2o"],"interface":"select-dropdown-m2o","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":[{"name":"Users Can Only See Their Own Message","rule":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"options":{"enableCreate":true,"enableSelect":true,"enableLink":false}}],"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"messages","field":"to","conditions":[{"name":"Users Can Only See Their Own Message","rule":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"options":{"enableCreate":true,"enableSelect":true,"enableLink":false}}],"validation":null}	\N	\N
23	44	messages	7ff1570b-0f6c-4d6e-9504-d4ec9d322744	{"content":"test messsage","to":"2d1c7579-a552-40c3-8951-5457699ce81a"}	{"content":"test messsage","to":"2d1c7579-a552-40c3-8951-5457699ce81a"}	\N	\N
24	45	messages	9f31fcb9-161b-46bf-b47e-5214d0b8bba3	{"content":"test message to full permissions user","status":"published","to":"313c5ea6-f636-46c6-932d-426e72f7c23f"}	{"content":"test message to full permissions user","status":"published","to":"313c5ea6-f636-46c6-932d-426e72f7c23f"}	\N	\N
25	46	messages	7ff1570b-0f6c-4d6e-9504-d4ec9d322744	{"id":"7ff1570b-0f6c-4d6e-9504-d4ec9d322744","status":"published","date_created":"2025-01-27T16:19:59.218Z","date_updated":"2025-01-27T16:20:26.717Z","content":"test messsage","to":"2d1c7579-a552-40c3-8951-5457699ce81a"}	{"status":"published","date_updated":"2025-01-27T16:20:26.717Z"}	\N	\N
26	48	directus_permissions	1	{"policy":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"messages","action":"read"}	{"policy":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7","permissions":null,"validation":null,"fields":["*"],"presets":null,"collection":"messages","action":"read"}	\N	\N
27	50	directus_permissions	1	{"id":1,"collection":"messages","action":"read","permissions":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation":null,"presets":null,"fields":["*"],"policy":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7"}	{"collection":"messages","action":"read","permissions":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation":null,"presets":null,"fields":["*"],"policy":"9ce012a6-6ddd-411f-9cbc-42877fbc51f7"}	\N	\N
28	52	directus_fields	8	{"id":8,"collection":"messages","field":"to","special":["m2o"],"interface":"select-dropdown-m2o","options":{"enableCreate":false},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"messages","field":"to","conditions":null}	\N	\N
29	53	directus_fields	9	{"sort":7,"interface":"input","special":null,"required":true,"options":{"placeholder":"The subject of the message"},"collection":"messages","field":"subject"}	{"sort":7,"interface":"input","special":null,"required":true,"options":{"placeholder":"The subject of the message"},"collection":"messages","field":"subject"}	\N	\N
30	54	messages	7ff1570b-0f6c-4d6e-9504-d4ec9d322744	{"id":"7ff1570b-0f6c-4d6e-9504-d4ec9d322744","status":"published","date_created":"2025-01-27T16:19:59.218Z","date_updated":"2025-01-27T16:37:06.321Z","content":"test messsage content","to":"2d1c7579-a552-40c3-8951-5457699ce81a","subject":"Test message"}	{"content":"test messsage content","subject":"Test message","date_updated":"2025-01-27T16:37:06.321Z"}	\N	\N
31	55	messages	9f31fcb9-161b-46bf-b47e-5214d0b8bba3	{"id":"9f31fcb9-161b-46bf-b47e-5214d0b8bba3","status":"published","date_created":"2025-01-27T16:20:20.571Z","date_updated":"2025-01-27T16:37:15.595Z","content":"test message content to full permissions user","to":"313c5ea6-f636-46c6-932d-426e72f7c23f","subject":"Test message"}	{"content":"test message content to full permissions user","subject":"Test message","date_updated":"2025-01-27T16:37:15.595Z"}	\N	\N
32	62	directus_fields	10	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"sjr"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"sjr"}	\N	\N
33	63	directus_fields	11	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"sjr"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"sjr"}	\N	\N
34	64	directus_fields	12	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"sjr"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"sjr"}	\N	\N
35	65	directus_collections	sjr	{"singleton":false,"collection":"sjr"}	{"singleton":false,"collection":"sjr"}	\N	\N
36	66	directus_fields	13	{"sort":4,"interface":"input","special":null,"required":true,"options":{"placeholder":"Snake Case Name for the rule"},"collection":"sjr","field":"machine_name"}	{"sort":4,"interface":"input","special":null,"required":true,"options":{"placeholder":"Snake Case Name for the rule"},"collection":"sjr","field":"machine_name"}	\N	\N
37	67	directus_fields	14	{"sort":5,"interface":"input","special":null,"options":{"placeholder":"Human readable name for the rule"},"required":true,"collection":"sjr","field":"name"}	{"sort":5,"interface":"input","special":null,"options":{"placeholder":"Human readable name for the rule"},"required":true,"collection":"sjr","field":"name"}	\N	\N
38	68	directus_fields	10	{"id":10,"collection":"sjr","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"sjr","field":"id","sort":1,"group":null}	\N	\N
39	69	directus_fields	11	{"id":11,"collection":"sjr","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"sjr","field":"date_created","sort":2,"group":null}	\N	\N
40	70	directus_fields	12	{"id":12,"collection":"sjr","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"sjr","field":"date_updated","sort":3,"group":null}	\N	\N
41	71	directus_fields	14	{"id":14,"collection":"sjr","field":"name","special":null,"interface":"input","options":{"placeholder":"Human readable name for the rule"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"sjr","field":"name","sort":4,"group":null}	\N	\N
42	72	directus_fields	13	{"id":13,"collection":"sjr","field":"machine_name","special":null,"interface":"input","options":{"placeholder":"Snake Case Name for the rule"},"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"sjr","field":"machine_name","sort":5,"group":null}	\N	\N
43	73	directus_collections	sjr	{"collection":"sjr","icon":"rule","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"icon":"rule"}	\N	\N
44	74	directus_fields	15	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"sjr_role"}	{"sort":1,"hidden":true,"readonly":true,"interface":"input","special":["uuid"],"field":"id","collection":"sjr_role"}	\N	\N
45	75	directus_fields	16	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"sjr_role"}	{"sort":2,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"sjr_role"}	\N	\N
46	76	directus_fields	17	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"sjr_role"}	{"sort":3,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"sjr_role"}	\N	\N
47	77	directus_collections	sjr_role	{"singleton":false,"collection":"sjr_role"}	{"singleton":false,"collection":"sjr_role"}	\N	\N
48	79	directus_fields	18	{"sort":6,"interface":"list-m2m","special":["m2m"],"required":true,"options":{"enableCreate":false},"collection":"sjr","field":"roles"}	{"sort":6,"interface":"list-m2m","special":["m2m"],"required":true,"options":{"enableCreate":false},"collection":"sjr","field":"roles"}	\N	\N
49	80	directus_fields	19	{"sort":1,"hidden":true,"field":"id","collection":"sjr_directus_roles"}	{"sort":1,"hidden":true,"field":"id","collection":"sjr_directus_roles"}	\N	\N
50	81	directus_collections	sjr_directus_roles	{"hidden":true,"icon":"import_export","collection":"sjr_directus_roles"}	{"hidden":true,"icon":"import_export","collection":"sjr_directus_roles"}	\N	\N
51	82	directus_fields	20	{"sort":2,"hidden":true,"collection":"sjr_directus_roles","field":"sjr_id"}	{"sort":2,"hidden":true,"collection":"sjr_directus_roles","field":"sjr_id"}	\N	\N
52	83	directus_fields	21	{"sort":3,"hidden":true,"collection":"sjr_directus_roles","field":"directus_roles_id"}	{"sort":3,"hidden":true,"collection":"sjr_directus_roles","field":"directus_roles_id"}	\N	\N
53	84	directus_roles	35ee142b-a2c5-4153-ba00-288c4b4ca386	{"name":"accurx"}	{"name":"accurx"}	\N	\N
74	110	directus_permissions	2	{"id":2,"collection":"sjr","action":"read","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	{"collection":"sjr","action":"read","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	\N	\N
56	87	directus_permissions	2	{"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2","permissions":{"_and":[{"roles":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"fields":null,"presets":null,"collection":"sjr","action":"read"}	{"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2","permissions":{"_and":[{"roles":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"fields":null,"presets":null,"collection":"sjr","action":"read"}	58	\N
57	88	directus_permissions	3	{"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2","permissions":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation":null,"fields":null,"presets":null,"collection":"messages","action":"read"}	{"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2","permissions":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation":null,"fields":null,"presets":null,"collection":"messages","action":"read"}	58	\N
58	89	directus_policies	e23cf42d-1cb2-4784-9971-61ec0bd105e2	{"permissions":{"create":[{"policy":"+","permissions":{"_and":[{"roles":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"fields":null,"presets":null,"collection":"sjr","action":"read"},{"policy":"+","permissions":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation":null,"fields":null,"presets":null,"collection":"messages","action":"read"}],"update":[],"delete":[]},"name":"User Group Access","app_access":true}	{"permissions":{"create":[{"policy":"+","permissions":{"_and":[{"roles":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"fields":null,"presets":null,"collection":"sjr","action":"read"},{"policy":"+","permissions":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation":null,"fields":null,"presets":null,"collection":"messages","action":"read"}],"update":[],"delete":[]},"name":"User Group Access","app_access":true}	59	\N
60	91	directus_roles	35ee142b-a2c5-4153-ba00-288c4b4ca386	{"id":"35ee142b-a2c5-4153-ba00-288c4b4ca386","name":"accurx","icon":"supervised_user_circle","description":"GP Supplier with limited permissions","parent":null,"children":[],"policies":["d88ecd3f-5b37-409c-8247-adde50dd746b"],"users":["2d1c7579-a552-40c3-8951-5457699ce81a","fc595e66-7a89-4db0-a272-77c75646d18e"]}	{"description":"GP Supplier with limited permissions"}	\N	\N
54	85	directus_users	2d1c7579-a552-40c3-8951-5457699ce81a	{"id":"2d1c7579-a552-40c3-8951-5457699ce81a","first_name":"Charlie","last_name":"Jacques","email":"charlie@test.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"35ee142b-a2c5-4153-ba00-288c4b4ca386","token":null,"last_access":"2025-01-28T12:37:11.710Z","last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"policies":["19c8702c-f9f1-417a-a858-043db1a99556"]}	{"role":"35ee142b-a2c5-4153-ba00-288c4b4ca386"}	60	\N
75	113	directus_permissions	2	{"id":2,"collection":"sjr","action":"read","permissions":{"_and":[{"roles":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"presets":null,"fields":["*"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	{"collection":"sjr","action":"read","permissions":{"_and":[{"roles":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"presets":null,"fields":["*"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	\N	\N
76	115	directus_permissions	2	{"id":2,"collection":"sjr","action":"read","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	{"collection":"sjr","action":"read","permissions":null,"validation":null,"presets":null,"fields":["*"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	\N	\N
77	117	directus_permissions	4	{"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2","permissions":{"_and":[{"directus_roles_id":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"fields":null,"presets":null,"collection":"sjr_directus_roles","action":"read"}	{"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2","permissions":{"_and":[{"directus_roles_id":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"fields":null,"presets":null,"collection":"sjr_directus_roles","action":"read"}	\N	\N
78	119	directus_permissions	2	{"id":2,"collection":"sjr","action":"read","permissions":{"_and":[{"roles":{"directus_roles_id":{"_eq":"$CURRENT_ROLE"}}}]},"validation":null,"presets":null,"fields":["*"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	{"collection":"sjr","action":"read","permissions":{"_and":[{"roles":{"directus_roles_id":{"_eq":"$CURRENT_ROLE"}}}]},"validation":null,"presets":null,"fields":["*"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	\N	\N
55	86	directus_users	fc595e66-7a89-4db0-a272-77c75646d18e	{"id":"fc595e66-7a89-4db0-a272-77c75646d18e","first_name":"Testing","last_name":"Limited-Permissions","email":"limited-permissions@test.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"35ee142b-a2c5-4153-ba00-288c4b4ca386","token":null,"last_access":null,"last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"policies":["6fde25df-ff9c-45a5-b026-6db2b6db4953"]}	{"role":"35ee142b-a2c5-4153-ba00-288c4b4ca386"}	60	\N
59	90	directus_access	d88ecd3f-5b37-409c-8247-adde50dd746b	{"policy":{"permissions":{"create":[{"policy":"+","permissions":{"_and":[{"roles":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"fields":null,"presets":null,"collection":"sjr","action":"read"},{"policy":"+","permissions":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation":null,"fields":null,"presets":null,"collection":"messages","action":"read"}],"update":[],"delete":[]},"name":"User Group Access","app_access":true},"sort":1,"role":"35ee142b-a2c5-4153-ba00-288c4b4ca386"}	{"policy":{"permissions":{"create":[{"policy":"+","permissions":{"_and":[{"roles":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"fields":null,"presets":null,"collection":"sjr","action":"read"},{"policy":"+","permissions":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation":null,"fields":null,"presets":null,"collection":"messages","action":"read"}],"update":[],"delete":[]},"name":"User Group Access","app_access":true},"sort":1,"role":"35ee142b-a2c5-4153-ba00-288c4b4ca386"}	60	\N
61	92	directus_roles	a1dd6fde-d3ed-4677-bdcb-36adefb46283	{"name":"pkb"}	{"name":"pkb"}	\N	\N
64	95	directus_roles	a1dd6fde-d3ed-4677-bdcb-36adefb46283	{"id":"a1dd6fde-d3ed-4677-bdcb-36adefb46283","name":"pkb","icon":"supervised_user_circle","description":"Test GP group","parent":null,"children":[],"policies":["511d0f2d-2049-4711-8b28-266464a80747"],"users":["313c5ea6-f636-46c6-932d-426e72f7c23f"]}	{"description":"Test GP group"}	\N	\N
62	93	directus_users	313c5ea6-f636-46c6-932d-426e72f7c23f	{"id":"313c5ea6-f636-46c6-932d-426e72f7c23f","first_name":"Testing","last_name":"Full-Permissions","email":"full-permissions@test.com","password":"**********","location":null,"title":null,"description":null,"tags":null,"avatar":null,"language":null,"tfa_secret":null,"status":"active","role":"a1dd6fde-d3ed-4677-bdcb-36adefb46283","token":null,"last_access":"2025-01-27T16:59:47.506Z","last_page":null,"provider":"default","external_identifier":null,"auth_data":null,"email_notifications":true,"appearance":null,"theme_dark":null,"theme_light":null,"theme_light_overrides":null,"theme_dark_overrides":null,"policies":["b796c415-047e-46d1-a7fc-63bcef5d0562"]}	{"role":"a1dd6fde-d3ed-4677-bdcb-36adefb46283"}	64	\N
63	94	directus_access	511d0f2d-2049-4711-8b28-266464a80747	{"role":"a1dd6fde-d3ed-4677-bdcb-36adefb46283","policy":{"id":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"},"sort":1}	{"role":"a1dd6fde-d3ed-4677-bdcb-36adefb46283","policy":{"id":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"},"sort":1}	64	\N
67	98	sjr	05f3500f-8741-46cf-9d50-36c28706e33a	{"roles":{"create":[{"sjr_id":"+","directus_roles_id":{"id":"a1dd6fde-d3ed-4677-bdcb-36adefb46283"}},{"sjr_id":"+","directus_roles_id":{"id":"35ee142b-a2c5-4153-ba00-288c4b4ca386"}}],"update":[],"delete":[]},"name":"Messages Access","machine_name":"gp_messages"}	{"roles":{"create":[{"sjr_id":"+","directus_roles_id":{"id":"a1dd6fde-d3ed-4677-bdcb-36adefb46283"}},{"sjr_id":"+","directus_roles_id":{"id":"35ee142b-a2c5-4153-ba00-288c4b4ca386"}}],"update":[],"delete":[]},"name":"Messages Access","machine_name":"gp_messages"}	\N	\N
65	96	sjr_directus_roles	1	{"sjr_id":"05f3500f-8741-46cf-9d50-36c28706e33a","directus_roles_id":{"id":"a1dd6fde-d3ed-4677-bdcb-36adefb46283"}}	{"sjr_id":"05f3500f-8741-46cf-9d50-36c28706e33a","directus_roles_id":{"id":"a1dd6fde-d3ed-4677-bdcb-36adefb46283"}}	67	\N
66	97	sjr_directus_roles	2	{"sjr_id":"05f3500f-8741-46cf-9d50-36c28706e33a","directus_roles_id":{"id":"35ee142b-a2c5-4153-ba00-288c4b4ca386"}}	{"sjr_id":"05f3500f-8741-46cf-9d50-36c28706e33a","directus_roles_id":{"id":"35ee142b-a2c5-4153-ba00-288c4b4ca386"}}	67	\N
69	100	sjr	e1d2d05a-8787-404d-946f-7192c5292b10	{"name":"Health Record Access","machine_name":"gp_record_access","roles":{"create":[{"sjr_id":"+","directus_roles_id":{"id":"a1dd6fde-d3ed-4677-bdcb-36adefb46283"}}],"update":[],"delete":[]}}	{"name":"Health Record Access","machine_name":"gp_record_access","roles":{"create":[{"sjr_id":"+","directus_roles_id":{"id":"a1dd6fde-d3ed-4677-bdcb-36adefb46283"}}],"update":[],"delete":[]}}	\N	\N
68	99	sjr_directus_roles	3	{"sjr_id":"e1d2d05a-8787-404d-946f-7192c5292b10","directus_roles_id":{"id":"a1dd6fde-d3ed-4677-bdcb-36adefb46283"}}	{"sjr_id":"e1d2d05a-8787-404d-946f-7192c5292b10","directus_roles_id":{"id":"a1dd6fde-d3ed-4677-bdcb-36adefb46283"}}	69	\N
70	101	directus_permissions	2	{"id":2,"collection":"sjr","action":"read","permissions":{"_and":[{"roles":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"presets":null,"fields":["id","date_created","date_updated","name","machine_name"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	{"collection":"sjr","action":"read","permissions":{"_and":[{"roles":{"_eq":"$CURRENT_ROLE"}}]},"validation":null,"presets":null,"fields":["id","date_created","date_updated","name","machine_name"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	\N	\N
71	102	directus_permissions	3	{"id":3,"collection":"messages","action":"read","permissions":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation":null,"presets":null,"fields":["id","status","date_created","date_updated","content","subject","to"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	{"collection":"messages","action":"read","permissions":{"_and":[{"to":{"_eq":"$CURRENT_USER"}}]},"validation":null,"presets":null,"fields":["id","status","date_created","date_updated","content","subject","to"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	\N	\N
72	106	directus_permissions	2	{"id":2,"collection":"sjr","action":"read","permissions":{"_and":[{"roles":{"_in":["$CURRENT_ROLE"]}}]},"validation":null,"presets":null,"fields":["id","date_created","date_updated","name","machine_name"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	{"collection":"sjr","action":"read","permissions":{"_and":[{"roles":{"_in":["$CURRENT_ROLE"]}}]},"validation":null,"presets":null,"fields":["id","date_created","date_updated","name","machine_name"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	\N	\N
73	108	directus_permissions	2	{"id":2,"collection":"sjr","action":"read","permissions":{"_and":[{"roles":{"_in":["$CURRENT_ROLE"]}}]},"validation":null,"presets":null,"fields":["id","date_created","date_updated","name","machine_name","roles"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	{"collection":"sjr","action":"read","permissions":{"_and":[{"roles":{"_in":["$CURRENT_ROLE"]}}]},"validation":null,"presets":null,"fields":["id","date_created","date_updated","name","machine_name","roles"],"policy":"e23cf42d-1cb2-4784-9971-61ec0bd105e2"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
ea221134-dcd8-4598-9ae2-d84a2a044a03	Administrator	verified	$t:admin_description	\N
35ee142b-a2c5-4153-ba00-288c4b4ca386	accurx	supervised_user_circle	GP Supplier with limited permissions	\N
a1dd6fde-d3ed-4677-bdcb-36adefb46283	pkb	supervised_user_circle	Test GP group	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
D0T-0Ih2L9WDphzabgJwgnaH82Jp7rL3QlUColZu7yv7MbGPvxR6QFHR2E1ui_2A	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-31 10:29:26.733+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:8055	\N
0sF_JnW010HsEYKjj3LSUAXOrLOclMWzXON3cEa5hVA__OTcVH899P4bHNiwsv-w	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-31 13:59:52.606+00	127.0.0.1	curl/8.7.1	\N	\N	\N
gGwRjfLmUTvkNKgyAz0juIuQt1xvNoca4HBCwQlR_hjMsgD2aifgxVrDb8OMc4d5	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-31 14:48:24.249+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
MBq17fnop6M5AjECrzQrHU1ldCmfAh8QKsJQvoMwrQ51CPCFqi13STJiL0Ztc1mL	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-31 14:49:54.142+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
pIkrzfJBUJL_w6NHrjjzW7-pwpxmUAsGb_4vLI72-s5-BZOvICaqPlmqB5h-g9Fi	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-31 14:50:31.081+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
N4rGDSQa491y25mtRrwLTDyWYvBKPmwLnoXElM-TaFehCWZiMByfyMJLh-Oj1WC2	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-31 14:50:45.565+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
Lo1_8B9eTcrOoXWUvloowd7yQMIajYDF8xschySO-Fx4tfp2aG-Q5PzmJUG8KJyj	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-31 14:54:43.32+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
xNAsfSY8PisYablIJQRfc0gPkgCCbzrOf3-RZ2cwSTdHC0u7iwl1-II2J3qYSFFz	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-31 14:54:45.486+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
p95mnF8WDAqXFA31559c7fd1TlqxdPPRB_buSdobK6kWG3u4anGJwDgQ8rL90mmC	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-31 15:19:22.94+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
uZIVSeV3AZ05XkJnwFPO3IBUIqoRsQcg4Efwsl6MxaQ_btY2RAmF80TKTTsg1A7s	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-31 15:19:27.727+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
XaZOeyYXDjQYu8Km1W67Ps7KUs_pX9i-rb8sQbHUkixx1X0oxyIQaAn4sV-HT67Q	2d1c7579-a552-40c3-8951-5457699ce81a	2025-01-31 15:20:59.843+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
uKqjIYteov3FoWtXA9v0UnxPBMsRCvIsAXm_kLFxA8BKwA5_eOFu1MCNYXeCUsgS	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-03 15:39:18.427+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
eFfYfHgLr5_EBMubzknxOCY32yEWw6jqeQulivgQarty8K5yYwDT5y7YfY4pCXXU	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-03 15:41:25.941+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
1ZcR1RBBamCDHGKwVECjqnLMlMiE6gBbSrDam5lTBFfYf-V_Yww3DBs4uxf2n1bN	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-03 15:42:11.926+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
hfwDqBhlbYNOUArgdYhqwuE98p5sZJI7ycuoe0z5eqQfCMjoteM8_YF9CIUXpKM9	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-03 15:47:35.165+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
G1MGgalaZvlcjbbRCaqASG6YjDWRkCrJl7FP71MlOMMl-qS89hmcXb15D4y81xKq	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-03 15:53:51.121+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
Cau2mtNS4wb_Y_m8zfoLyc4cBjghJXWuPJplwtJIPcoe0wY4FbmL2cBSCaTdQtKj	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-03 15:55:11.866+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
_QDmJvpVzJUg5CCy22LLXhBi6gIdfs-N4sPzvWbhYUomaiBefE1pcQB8IqRnbT5y	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-04 11:57:56.343+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	\N	http://localhost:5173	\N
LABmfzKp4BDHcjLi9fKTzFMYjFqKwbtrPNdWxAWvBbl_3eP1zqi8VVVWc6t69K4V	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-04 12:37:11.699+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	\N	http://localhost:5173	\N
1Y49-203S9JwP5kCrAgEN_lFvc1adMDkRNGF0wycy_gkuCM0qcsUN5V_RKRCN_PF	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-03 16:26:36.183+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
CMDG1QSPa2_ItnUwl33JxFzv51zzd0T3qx_l15SVSFMOe232dsPkysE-M4PjUQuo	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-03 16:50:19.441+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
K7d4bKbpg1iYeXOeh-x8KAx6A39OJ6uN8Dwk5itcISkB1WzN87hit7ROj658p0yp	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-02-04 12:53:26.346+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:8055	\N
t0C9HKMHkf_D-zVqCr-V7TIsnxz02PNxSN_QVePwMtFtPwe-nyzkapRUw6lypuuv	88d552a3-0515-443b-9e23-109ddacd9d0a	2025-01-28 16:57:28.798+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:8055	\N
6NpNs_9qhxsmHmSePaGzcvBqnxGoU1ytu1zGJJuHE0LESoEE9fSwxsMOp1xbW43d	313c5ea6-f636-46c6-932d-426e72f7c23f	2025-02-03 16:59:47.498+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
0B-69b5EF9Htt3z2a4dxvRIEH20l30x96q2BrrWIlZtEC6ama4d_WqmZsu2nJx67	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-03 17:07:19.459+00	127.0.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:134.0) Gecko/20100101 Firefox/134.0	\N	http://localhost:5173	\N
_GOKK98RXCh6cCTrYWoGlBK0yfJZ47NJAbEvLeSRHBR56o5X-GHrC7ewDAXaNRTE	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-04 13:26:07.154+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	\N	http://localhost:5173	\N
fvwF_A-5-4i1E3b8EIWi_eBHklQFmMhWQBY0SU3tEEYv2lBa41FXlfCCoog2Cb_4	313c5ea6-f636-46c6-932d-426e72f7c23f	2025-02-04 13:26:22.206+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	\N	http://localhost:5173	\N
7HXKgWqRnapUQ8ga9ACkzzCg7UstD5xG7CPJF4j6OV-NTbBO88sFbYTVn_RBgt3W	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-04 13:45:19.611+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	\N	http://localhost:5173	\N
3cerZlchia66gV8rUa7RRpA_fUpg2OuyHQoZGPnIyuxyrMfUXw2pzEf9RSpU3O1Q	313c5ea6-f636-46c6-932d-426e72f7c23f	2025-02-04 13:50:09.579+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	\N	http://localhost:5173	\N
OjRxa0VK1n2nYCOBsRdldKGgH6X9JNHKItUvdDowJEN40b_9qNY2VSTTYE4lHtQL	2d1c7579-a552-40c3-8951-5457699ce81a	2025-02-04 13:52:13.619+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	\N	http://localhost:5173	\N
Hia1wlcIvvgGBknX8KMqzJGyRCEZgoShJcn9s13T5E4fq31Qm-CTf08WNBiKC3gg	313c5ea6-f636-46c6-932d-426e72f7c23f	2025-02-04 13:52:27.62+00	127.0.0.1	Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Mobile Safari/537.36	\N	http://localhost:5173	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter) FROM stdin;
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides) FROM stdin;
2d1c7579-a552-40c3-8951-5457699ce81a	Charlie	Jacques	charlie@test.com	$argon2id$v=19$m=65536,t=3,p=4$oe8DyNEzkwl4A/s01mgBXw$ALqF8cP6WKdYcIsw+VV9MVh8nqdXokQnIRUIduFWF3s	\N	\N	\N	\N	\N	\N	\N	active	35ee142b-a2c5-4153-ba00-288c4b4ca386	\N	2025-01-28 13:52:13.628+00	\N	default	\N	\N	t	\N	\N	\N	\N	\N
313c5ea6-f636-46c6-932d-426e72f7c23f	Testing	Full-Permissions	full-permissions@test.com	$argon2id$v=19$m=65536,t=3,p=4$53Nf5mUiOKBQuvncVNZVEA$3jVvYTviHWELzovguJhg/3CoL6L62PLg53FtlLBD7Fk	\N	\N	\N	\N	\N	\N	\N	active	a1dd6fde-d3ed-4677-bdcb-36adefb46283	\N	2025-01-28 13:52:27.63+00	\N	default	\N	\N	t	\N	\N	\N	\N	\N
fc595e66-7a89-4db0-a272-77c75646d18e	Testing	Limited-Permissions	limited-permissions@test.com	$argon2id$v=19$m=65536,t=3,p=4$GEj3GLrtCaayH0i0Okz5Xw$LCbBqJjKFXp0KdqyirKxEIFmgr/4lRnvkUO2246TT2g	\N	\N	\N	\N	\N	\N	\N	active	35ee142b-a2c5-4153-ba00-288c4b4ca386	\N	\N	\N	default	\N	\N	t	\N	\N	\N	\N	\N
88d552a3-0515-443b-9e23-109ddacd9d0a	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$FzfBAIo9QUhuziBMLqpdEg$hKFJ8fOZMa5Me0y0aGDmE+vcSHG2wmCG4YWhUT3Siys	\N	\N	\N	\N	\N	\N	\N	active	ea221134-dcd8-4598-9ae2-d84a2a044a03	\N	2025-01-28 12:53:26.364+00	/content/sjr	default	\N	\N	t	\N	\N	\N	\N	\N
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers, was_active_before_deprecation, migrated_flow) FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.messages (id, status, date_created, date_updated, content, "to", subject) FROM stdin;
7ff1570b-0f6c-4d6e-9504-d4ec9d322744	published	2025-01-27 16:19:59.218+00	2025-01-27 16:37:06.321+00	test messsage content	2d1c7579-a552-40c3-8951-5457699ce81a	Test message
9f31fcb9-161b-46bf-b47e-5214d0b8bba3	published	2025-01-27 16:20:20.571+00	2025-01-27 16:37:15.595+00	test message content to full permissions user	313c5ea6-f636-46c6-932d-426e72f7c23f	Test message
\.


--
-- Data for Name: sjr; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.sjr (id, date_created, date_updated, machine_name, name) FROM stdin;
05f3500f-8741-46cf-9d50-36c28706e33a	2025-01-28 13:04:24.933+00	\N	gp_messages	Messages Access
e1d2d05a-8787-404d-946f-7192c5292b10	2025-01-28 13:04:44.461+00	\N	gp_record_access	Health Record Access
\.


--
-- Data for Name: sjr_directus_roles; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY public.sjr_directus_roles (id, sjr_id, directus_roles_id) FROM stdin;
1	05f3500f-8741-46cf-9d50-36c28706e33a	a1dd6fde-d3ed-4677-bdcb-36adefb46283
2	05f3500f-8741-46cf-9d50-36c28706e33a	35ee142b-a2c5-4153-ba00-288c4b4ca386
3	e1d2d05a-8787-404d-946f-7192c5292b10	a1dd6fde-d3ed-4677-bdcb-36adefb46283
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pguser
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 124, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pguser
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 21, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pguser
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pguser
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 4, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pguser
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 1, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pguser
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 4, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pguser
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 78, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pguser
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pguser
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: sjr_directus_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pguser
--

SELECT pg_catalog.setval('public.sjr_directus_roles_id_seq', 3, true);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: sjr_directus_roles sjr_directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.sjr_directus_roles
    ADD CONSTRAINT sjr_directus_roles_pkey PRIMARY KEY (id);


--
-- Name: sjr sjr_pkey; Type: CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.sjr
    ADD CONSTRAINT sjr_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_webhooks directus_webhooks_migrated_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_migrated_flow_foreign FOREIGN KEY (migrated_flow) REFERENCES public.directus_flows(id) ON DELETE SET NULL;


--
-- Name: messages messages_to_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_to_foreign FOREIGN KEY ("to") REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: sjr_directus_roles sjr_directus_roles_directus_roles_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.sjr_directus_roles
    ADD CONSTRAINT sjr_directus_roles_directus_roles_id_foreign FOREIGN KEY (directus_roles_id) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: sjr_directus_roles sjr_directus_roles_sjr_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: pguser
--

ALTER TABLE ONLY public.sjr_directus_roles
    ADD CONSTRAINT sjr_directus_roles_sjr_id_foreign FOREIGN KEY (sjr_id) REFERENCES public.sjr(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

