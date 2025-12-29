--
-- PostgreSQL database dump
--

\restrict HHyPM11iJ4RTidGIADNUroeHULqcwIOblEdasJz42teju0Ughm5QqGxGWMzqd8f

-- Dumped from database version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)

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

DROP DATABASE IF EXISTS myapp;
--
-- Name: myapp; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE myapp WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';


ALTER DATABASE myapp OWNER TO postgres;

\unrestrict HHyPM11iJ4RTidGIADNUroeHULqcwIOblEdasJz42teju0Ughm5QqGxGWMzqd8f
\connect myapp
\restrict HHyPM11iJ4RTidGIADNUroeHULqcwIOblEdasJz42teju0Ughm5QqGxGWMzqd8f

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
-- Name: bug_severity; Type: TYPE; Schema: public; Owner: appuser
--

CREATE TYPE public.bug_severity AS ENUM (
    'low',
    'medium',
    'high',
    'critical'
);


ALTER TYPE public.bug_severity OWNER TO appuser;

--
-- Name: bug_status; Type: TYPE; Schema: public; Owner: appuser
--

CREATE TYPE public.bug_status AS ENUM (
    'open',
    'in_progress',
    'resolved',
    'closed'
);


ALTER TYPE public.bug_status OWNER TO appuser;

--
-- Name: job_status; Type: TYPE; Schema: public; Owner: appuser
--

CREATE TYPE public.job_status AS ENUM (
    'pending',
    'running',
    'completed',
    'failed'
);


ALTER TYPE public.job_status OWNER TO appuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AnalysisJob; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."AnalysisJob" (
    id integer NOT NULL,
    source_code_id integer NOT NULL,
    status character varying(32) NOT NULL,
    started_at timestamp without time zone,
    completed_at timestamp without time zone,
    created_by integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."AnalysisJob" OWNER TO appuser;

--
-- Name: AnalysisJob_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public."AnalysisJob_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."AnalysisJob_id_seq" OWNER TO appuser;

--
-- Name: AnalysisJob_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public."AnalysisJob_id_seq" OWNED BY public."AnalysisJob".id;


--
-- Name: AuditLog; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."AuditLog" (
    id integer NOT NULL,
    user_id integer,
    action character varying(128) NOT NULL,
    target_type character varying(64) NOT NULL,
    target_id integer NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL,
    details text
);


ALTER TABLE public."AuditLog" OWNER TO appuser;

--
-- Name: AuditLog_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public."AuditLog_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."AuditLog_id_seq" OWNER TO appuser;

--
-- Name: AuditLog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public."AuditLog_id_seq" OWNED BY public."AuditLog".id;


--
-- Name: BugReport; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."BugReport" (
    id integer NOT NULL,
    title character varying(256) NOT NULL,
    description text,
    severity character varying(16) NOT NULL,
    status character varying(32) NOT NULL,
    assigned_to integer,
    created_by integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    exported boolean DEFAULT false NOT NULL
);


ALTER TABLE public."BugReport" OWNER TO appuser;

--
-- Name: BugReportAttachment; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."BugReportAttachment" (
    id integer NOT NULL,
    bug_report_id integer NOT NULL,
    file_path character varying(256) NOT NULL,
    uploaded_by integer NOT NULL,
    uploaded_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."BugReportAttachment" OWNER TO appuser;

--
-- Name: BugReportAttachment_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public."BugReportAttachment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."BugReportAttachment_id_seq" OWNER TO appuser;

--
-- Name: BugReportAttachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public."BugReportAttachment_id_seq" OWNED BY public."BugReportAttachment".id;


--
-- Name: BugReportComment; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."BugReportComment" (
    id integer NOT NULL,
    bug_report_id integer NOT NULL,
    user_id integer NOT NULL,
    comment text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."BugReportComment" OWNER TO appuser;

--
-- Name: BugReportComment_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public."BugReportComment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."BugReportComment_id_seq" OWNER TO appuser;

--
-- Name: BugReportComment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public."BugReportComment_id_seq" OWNED BY public."BugReportComment".id;


--
-- Name: BugReport_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public."BugReport_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."BugReport_id_seq" OWNER TO appuser;

--
-- Name: BugReport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public."BugReport_id_seq" OWNED BY public."BugReport".id;


--
-- Name: Notification; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."Notification" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type character varying(32) NOT NULL,
    message text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Notification" OWNER TO appuser;

--
-- Name: NotificationPreference; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."NotificationPreference" (
    user_id integer NOT NULL,
    preference character varying(16) NOT NULL
);


ALTER TABLE public."NotificationPreference" OWNER TO appuser;

--
-- Name: Notification_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public."Notification_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Notification_id_seq" OWNER TO appuser;

--
-- Name: Notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public."Notification_id_seq" OWNED BY public."Notification".id;


--
-- Name: Permission; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."Permission" (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(256)
);


ALTER TABLE public."Permission" OWNER TO appuser;

--
-- Name: Permission_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public."Permission_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Permission_id_seq" OWNER TO appuser;

--
-- Name: Permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public."Permission_id_seq" OWNED BY public."Permission".id;


--
-- Name: Role; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."Role" (
    id integer NOT NULL,
    name character varying(32) NOT NULL,
    description character varying(256),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."Role" OWNER TO appuser;

--
-- Name: RolePermission; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."RolePermission" (
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public."RolePermission" OWNER TO appuser;

--
-- Name: Role_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public."Role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Role_id_seq" OWNER TO appuser;

--
-- Name: Role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public."Role_id_seq" OWNED BY public."Role".id;


--
-- Name: SystemConfig; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."SystemConfig" (
    key character varying(64) NOT NULL,
    value text NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."SystemConfig" OWNER TO appuser;

--
-- Name: User; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    username character varying(64) NOT NULL,
    email character varying(128) NOT NULL,
    password_hash character varying(256) NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    is_superuser boolean DEFAULT false NOT NULL,
    mfa_secret character varying(128),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public."User" OWNER TO appuser;

--
-- Name: UserRole; Type: TABLE; Schema: public; Owner: appuser
--

CREATE TABLE public."UserRole" (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public."UserRole" OWNER TO appuser;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: appuser
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO appuser;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: appuser
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: AnalysisJob id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."AnalysisJob" ALTER COLUMN id SET DEFAULT nextval('public."AnalysisJob_id_seq"'::regclass);


--
-- Name: AuditLog id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."AuditLog" ALTER COLUMN id SET DEFAULT nextval('public."AuditLog_id_seq"'::regclass);


--
-- Name: BugReport id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReport" ALTER COLUMN id SET DEFAULT nextval('public."BugReport_id_seq"'::regclass);


--
-- Name: BugReportAttachment id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReportAttachment" ALTER COLUMN id SET DEFAULT nextval('public."BugReportAttachment_id_seq"'::regclass);


--
-- Name: BugReportComment id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReportComment" ALTER COLUMN id SET DEFAULT nextval('public."BugReportComment_id_seq"'::regclass);


--
-- Name: Notification id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."Notification" ALTER COLUMN id SET DEFAULT nextval('public."Notification_id_seq"'::regclass);


--
-- Name: Permission id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."Permission" ALTER COLUMN id SET DEFAULT nextval('public."Permission_id_seq"'::regclass);


--
-- Name: Role id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."Role" ALTER COLUMN id SET DEFAULT nextval('public."Role_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: AnalysisJob; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."AnalysisJob" (id, source_code_id, status, started_at, completed_at, created_by, created_at) FROM stdin;
\.


--
-- Data for Name: AuditLog; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."AuditLog" (id, user_id, action, target_type, target_id, "timestamp", details) FROM stdin;
\.


--
-- Data for Name: BugReport; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."BugReport" (id, title, description, severity, status, assigned_to, created_by, created_at, updated_at, exported) FROM stdin;
1	Null pointer dereference	Potential null pointer access in module X	high	open	\N	1	2025-12-29 09:55:44.822426	2025-12-29 09:55:44.822426	f
2	SQL Injection risk	User input concatenated into query without sanitization	critical	open	\N	1	2025-12-29 09:55:47.894457	2025-12-29 09:55:47.894457	f
\.


--
-- Data for Name: BugReportAttachment; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."BugReportAttachment" (id, bug_report_id, file_path, uploaded_by, uploaded_at) FROM stdin;
\.


--
-- Data for Name: BugReportComment; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."BugReportComment" (id, bug_report_id, user_id, comment, created_at) FROM stdin;
\.


--
-- Data for Name: Notification; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."Notification" (id, user_id, type, message, is_read, created_at) FROM stdin;
\.


--
-- Data for Name: NotificationPreference; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."NotificationPreference" (user_id, preference) FROM stdin;
\.


--
-- Data for Name: Permission; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."Permission" (id, name, description) FROM stdin;
\.


--
-- Data for Name: Role; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."Role" (id, name, description, created_at) FROM stdin;
1	admin	Administrator with full access	2025-12-29 09:55:23.427606
2	developer	Developer role with write access	2025-12-29 09:55:25.772603
3	viewer	Viewer role with read-only access	2025-12-29 09:55:27.943717
\.


--
-- Data for Name: RolePermission; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."RolePermission" (role_id, permission_id) FROM stdin;
\.


--
-- Data for Name: SystemConfig; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."SystemConfig" (key, value, updated_at) FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."User" (id, username, email, password_hash, is_active, is_superuser, mfa_secret, created_at, updated_at) FROM stdin;
1	admin	admin@example.com	b2/0123456789abcdefABCDEFgh	t	t	\N	2025-12-29 09:55:31.231624	2025-12-29 09:55:31.231624
\.


--
-- Data for Name: UserRole; Type: TABLE DATA; Schema: public; Owner: appuser
--

COPY public."UserRole" (user_id, role_id) FROM stdin;
1	1
\.


--
-- Name: AnalysisJob_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public."AnalysisJob_id_seq"', 1, false);


--
-- Name: AuditLog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public."AuditLog_id_seq"', 1, false);


--
-- Name: BugReportAttachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public."BugReportAttachment_id_seq"', 1, false);


--
-- Name: BugReportComment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public."BugReportComment_id_seq"', 1, false);


--
-- Name: BugReport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public."BugReport_id_seq"', 2, true);


--
-- Name: Notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public."Notification_id_seq"', 1, false);


--
-- Name: Permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public."Permission_id_seq"', 1, false);


--
-- Name: Role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public."Role_id_seq"', 3, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: appuser
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, true);


--
-- Name: AnalysisJob AnalysisJob_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."AnalysisJob"
    ADD CONSTRAINT "AnalysisJob_pkey" PRIMARY KEY (id);


--
-- Name: AuditLog AuditLog_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."AuditLog"
    ADD CONSTRAINT "AuditLog_pkey" PRIMARY KEY (id);


--
-- Name: BugReportAttachment BugReportAttachment_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReportAttachment"
    ADD CONSTRAINT "BugReportAttachment_pkey" PRIMARY KEY (id);


--
-- Name: BugReportComment BugReportComment_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReportComment"
    ADD CONSTRAINT "BugReportComment_pkey" PRIMARY KEY (id);


--
-- Name: BugReport BugReport_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReport"
    ADD CONSTRAINT "BugReport_pkey" PRIMARY KEY (id);


--
-- Name: NotificationPreference NotificationPreference_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."NotificationPreference"
    ADD CONSTRAINT "NotificationPreference_pkey" PRIMARY KEY (user_id);


--
-- Name: Notification Notification_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_pkey" PRIMARY KEY (id);


--
-- Name: Permission Permission_name_key; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."Permission"
    ADD CONSTRAINT "Permission_name_key" UNIQUE (name);


--
-- Name: Permission Permission_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."Permission"
    ADD CONSTRAINT "Permission_pkey" PRIMARY KEY (id);


--
-- Name: RolePermission RolePermission_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "RolePermission_pkey" PRIMARY KEY (role_id, permission_id);


--
-- Name: Role Role_name_key; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_name_key" UNIQUE (name);


--
-- Name: Role Role_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY (id);


--
-- Name: SystemConfig SystemConfig_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."SystemConfig"
    ADD CONSTRAINT "SystemConfig_pkey" PRIMARY KEY (key);


--
-- Name: UserRole UserRole_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY (user_id, role_id);


--
-- Name: User User_email_key; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: User User_username_key; Type: CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_username_key" UNIQUE (username);


--
-- Name: AnalysisJob AnalysisJob_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."AnalysisJob"
    ADD CONSTRAINT "AnalysisJob_created_by_fkey" FOREIGN KEY (created_by) REFERENCES public."User"(id);


--
-- Name: AnalysisJob AnalysisJob_source_code_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."AnalysisJob"
    ADD CONSTRAINT "AnalysisJob_source_code_id_fkey" FOREIGN KEY (source_code_id) REFERENCES public."BugReport"(id);


--
-- Name: AuditLog AuditLog_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."AuditLog"
    ADD CONSTRAINT "AuditLog_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: BugReportAttachment BugReportAttachment_bug_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReportAttachment"
    ADD CONSTRAINT "BugReportAttachment_bug_report_id_fkey" FOREIGN KEY (bug_report_id) REFERENCES public."BugReport"(id) ON DELETE CASCADE;


--
-- Name: BugReportAttachment BugReportAttachment_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReportAttachment"
    ADD CONSTRAINT "BugReportAttachment_uploaded_by_fkey" FOREIGN KEY (uploaded_by) REFERENCES public."User"(id);


--
-- Name: BugReportComment BugReportComment_bug_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReportComment"
    ADD CONSTRAINT "BugReportComment_bug_report_id_fkey" FOREIGN KEY (bug_report_id) REFERENCES public."BugReport"(id) ON DELETE CASCADE;


--
-- Name: BugReportComment BugReportComment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReportComment"
    ADD CONSTRAINT "BugReportComment_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: BugReport BugReport_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReport"
    ADD CONSTRAINT "BugReport_assigned_to_fkey" FOREIGN KEY (assigned_to) REFERENCES public."User"(id);


--
-- Name: BugReport BugReport_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."BugReport"
    ADD CONSTRAINT "BugReport_created_by_fkey" FOREIGN KEY (created_by) REFERENCES public."User"(id);


--
-- Name: NotificationPreference NotificationPreference_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."NotificationPreference"
    ADD CONSTRAINT "NotificationPreference_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON DELETE CASCADE;


--
-- Name: Notification Notification_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id);


--
-- Name: RolePermission RolePermission_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "RolePermission_permission_id_fkey" FOREIGN KEY (permission_id) REFERENCES public."Permission"(id) ON DELETE CASCADE;


--
-- Name: RolePermission RolePermission_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."RolePermission"
    ADD CONSTRAINT "RolePermission_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public."Role"(id) ON DELETE CASCADE;


--
-- Name: UserRole UserRole_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_role_id_fkey" FOREIGN KEY (role_id) REFERENCES public."Role"(id) ON DELETE CASCADE;


--
-- Name: UserRole UserRole_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: appuser
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public."User"(id) ON DELETE CASCADE;


--
-- Name: DATABASE myapp; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE myapp TO appuser;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO appuser;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO appuser;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TYPES TO appuser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO appuser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO appuser;


--
-- PostgreSQL database dump complete
--

\unrestrict HHyPM11iJ4RTidGIADNUroeHULqcwIOblEdasJz42teju0Ughm5QqGxGWMzqd8f

