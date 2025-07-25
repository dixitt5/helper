CREATE TABLE "saved_replies" (
	"created_at" timestamp with time zone NOT NULL,
	"updated_at" timestamp with time zone NOT NULL,
	"id" bigint PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY (sequence name "saved_replies_id_seq" INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START WITH 1 CACHE 1),
	"slug" varchar(50) NOT NULL,
	"name" varchar(100) NOT NULL,
	"content" text NOT NULL,
	"mailbox_id" bigint NOT NULL,
	"created_by_user_id" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"usage_count" integer DEFAULT 0 NOT NULL
);

ALTER TABLE "saved_replies" ENABLE ROW LEVEL SECURITY;
CREATE INDEX "saved_replies_mailbox_id_idx" ON "saved_replies" USING btree ("mailbox_id");
CREATE INDEX "saved_replies_created_by_user_idx" ON "saved_replies" USING btree ("created_by_user_id");
CREATE INDEX "saved_replies_slug_idx" ON "saved_replies" USING btree ("slug");
ALTER TABLE "saved_replies" ADD CONSTRAINT "saved_replies_mailbox_id_mailboxes_mailbox_id_fk" FOREIGN KEY ("mailbox_id") REFERENCES "public"."mailboxes_mailbox"("id") ON DELETE cascade ON UPDATE no action;
CREATE UNIQUE INDEX "saved_replies_slug_mailbox_unique" ON "saved_replies" USING btree ("slug","mailbox_id");