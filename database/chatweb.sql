-- ** Database generated with pgModeler (PostgreSQL Database Modeler).
-- ** pgModeler version: 1.2.3
-- ** PostgreSQL version: 18.0
-- ** Project Site: pgmodeler.io
-- ** Model Author: ---

-- ** Database creation must be performed outside a multi lined SQL file. 
-- ** These commands were put in this file only as a convenience.

-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE chat_web;
-- ddl-end --


SET search_path TO pg_catalog,public;
-- ddl-end --

-- object: public.users | type: TABLE --
-- DROP TABLE IF EXISTS public.users CASCADE;
CREATE TABLE public.users (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	gender varchar(1),
	email varchar(150) NOT NULL,
	phone_number varchar(15),
	status boolean NOT NULL DEFAULT true,
	created_at timestamptz NOT NULL DEFAULT now(),
	updated_at timestamptz NOT NULL DEFAULT now(),
	deleted_at timestamptz,
	password varchar(200) NOT NULL,
	CONSTRAINT users_pk PRIMARY KEY (id),
	CONSTRAINT "UQ_EMAIL" UNIQUE (email),
	CONSTRAINT "UQ_PHONE_NUMBER" UNIQUE (phone_number)
);
-- ddl-end --
ALTER TABLE public.users OWNER TO postgres;
-- ddl-end --

-- object: public.chat | type: TABLE --
-- DROP TABLE IF EXISTS public.chat CASCADE;
CREATE TABLE public.chat (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	name varchar(50),
	type varchar(20) NOT NULL,
	id_user_created_by uuid NOT NULL,
	created_at timestamptz NOT NULL DEFAULT now(),
	updated_at timestamptz NOT NULL DEFAULT now(),
	deleted_at timestamptz,
	CONSTRAINT chat_pk PRIMARY KEY (id),
	CONSTRAINT chk_chat_type CHECK (type IN ('DIRECT', 'GROUP'))
);
-- ddl-end --
ALTER TABLE public.chat OWNER TO postgres;
-- ddl-end --

-- object: public.messages | type: TABLE --
-- DROP TABLE IF EXISTS public.messages CASCADE;
CREATE TABLE public.messages (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	id_chat uuid NOT NULL,
	id_sender uuid NOT NULL,
	text text NOT NULL,
	reply_to_message_id uuid,
	created_at timestamptz NOT NULL DEFAULT now(),
	updated_at timestamptz NOT NULL DEFAULT now(),
	CONSTRAINT messages_pk PRIMARY KEY (id)
);
-- ddl-end --
ALTER TABLE public.messages OWNER TO postgres;
-- ddl-end --

-- object: public.message_read | type: TABLE --
-- DROP TABLE IF EXISTS public.message_read CASCADE;
CREATE TABLE public.message_read (
	id_message uuid NOT NULL,
	id_user uuid NOT NULL,
	read_at timestamptz NOT NULL DEFAULT now(),
	CONSTRAINT message_read_pk PRIMARY KEY (id_message,id_user)
);
-- ddl-end --
ALTER TABLE public.message_read OWNER TO postgres;
-- ddl-end --

-- object: public.user_chat | type: TABLE --
-- DROP TABLE IF EXISTS public.user_chat CASCADE;
CREATE TABLE public.user_chat (
	id_user uuid NOT NULL,
	id_chat uuid NOT NULL,
	role varchar(20) NOT NULL DEFAULT 'MEMBER',
	is_muted boolean NOT NULL DEFAULT false,
	is_archived boolean NOT NULL DEFAULT false,
	left_at timestamptz,
	joined_at timestamptz NOT NULL DEFAULT now(),
	created_at timestamptz NOT NULL DEFAULT now(),
	updated_at timestamptz NOT NULL DEFAULT now(),
	deleted_at timestamptz,
	CONSTRAINT user_chat_pk PRIMARY KEY (id_user,id_chat),
	CONSTRAINT chk_user_chat_role CHECK (role IN ('OWNER', 'ADMIN', 'MEMBER'))
);
-- ddl-end --
ALTER TABLE public.user_chat OWNER TO postgres;
-- ddl-end --

-- object: index_user_first_name | type: INDEX --
-- DROP INDEX IF EXISTS public.index_user_first_name CASCADE;
CREATE INDEX index_user_first_name ON public.users
USING btree
(
	first_name,
	last_name
);
-- ddl-end --

-- object: idx_user_chat_id_user_id_chat | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_user_chat_id_user_id_chat CASCADE;
CREATE INDEX idx_user_chat_id_user_id_chat ON public.user_chat
USING btree
(
	id_chat,
	id_user
);
-- ddl-end --

-- object: idx_chat_name | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_chat_name CASCADE;
CREATE INDEX idx_chat_name ON public.chat
USING btree
(
	name
);
-- ddl-end --

-- object: idx_messages_chat_created_at | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_messages_chat_created_at CASCADE;
CREATE INDEX idx_messages_chat_created_at ON public.messages
USING btree
(
	id_sender,
	id_chat
);
-- ddl-end --

-- object: idx_messages_sender | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_messages_sender CASCADE;
CREATE INDEX idx_messages_sender ON public.messages
USING btree
(
	id_sender
);
-- ddl-end --

-- object: idx_message_read_user | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_message_read_user CASCADE;
CREATE INDEX idx_message_read_user ON public.message_read
USING btree
(
	id_user
);
-- ddl-end --

-- object: "FK_ID_USER_CREATED_USERS" | type: CONSTRAINT --
-- ALTER TABLE public.chat DROP CONSTRAINT IF EXISTS "FK_ID_USER_CREATED_USERS" CASCADE;
ALTER TABLE public.chat ADD CONSTRAINT "FK_ID_USER_CREATED_USERS" FOREIGN KEY (id_user_created_by)
REFERENCES public.users (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MESSAGES_CHAT" | type: CONSTRAINT --
-- ALTER TABLE public.messages DROP CONSTRAINT IF EXISTS "FK_MESSAGES_CHAT" CASCADE;
ALTER TABLE public.messages ADD CONSTRAINT "FK_MESSAGES_CHAT" FOREIGN KEY (id_chat)
REFERENCES public.chat (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_ID_SENDER_USER" | type: CONSTRAINT --
-- ALTER TABLE public.messages DROP CONSTRAINT IF EXISTS "FK_ID_SENDER_USER" CASCADE;
ALTER TABLE public.messages ADD CONSTRAINT "FK_ID_SENDER_USER" FOREIGN KEY (id_sender)
REFERENCES public.users (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_REPLY_MESSAGE_MESSAGES" | type: CONSTRAINT --
-- ALTER TABLE public.messages DROP CONSTRAINT IF EXISTS "FK_REPLY_MESSAGE_MESSAGES" CASCADE;
ALTER TABLE public.messages ADD CONSTRAINT "FK_REPLY_MESSAGE_MESSAGES" FOREIGN KEY (reply_to_message_id)
REFERENCES public.messages (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_MESSAGES_USER_CHAT" | type: CONSTRAINT --
-- ALTER TABLE public.messages DROP CONSTRAINT IF EXISTS "FK_MESSAGES_USER_CHAT" CASCADE;
ALTER TABLE public.messages ADD CONSTRAINT "FK_MESSAGES_USER_CHAT" FOREIGN KEY (id_chat,id_sender)
REFERENCES public.user_chat (id_chat,id_user) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_USER_ID_MESSAGE_READ" | type: CONSTRAINT --
-- ALTER TABLE public.message_read DROP CONSTRAINT IF EXISTS "FK_USER_ID_MESSAGE_READ" CASCADE;
ALTER TABLE public.message_read ADD CONSTRAINT "FK_USER_ID_MESSAGE_READ" FOREIGN KEY (id_user)
REFERENCES public.users (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_ID_MESSAGE_MESSAGES" | type: CONSTRAINT --
-- ALTER TABLE public.message_read DROP CONSTRAINT IF EXISTS "FK_ID_MESSAGE_MESSAGES" CASCADE;
ALTER TABLE public.message_read ADD CONSTRAINT "FK_ID_MESSAGE_MESSAGES" FOREIGN KEY (id_message)
REFERENCES public.messages (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_USERS_USER_CHAT" | type: CONSTRAINT --
-- ALTER TABLE public.user_chat DROP CONSTRAINT IF EXISTS "FK_USERS_USER_CHAT" CASCADE;
ALTER TABLE public.user_chat ADD CONSTRAINT "FK_USERS_USER_CHAT" FOREIGN KEY (id_user)
REFERENCES public.users (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "FK_CHAT_USER_CHAT" | type: CONSTRAINT --
-- ALTER TABLE public.user_chat DROP CONSTRAINT IF EXISTS "FK_CHAT_USER_CHAT" CASCADE;
ALTER TABLE public.user_chat ADD CONSTRAINT "FK_CHAT_USER_CHAT" FOREIGN KEY (id_chat)
REFERENCES public.chat (id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


