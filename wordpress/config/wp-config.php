<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', '{{bind.database.first.cfg.username}}');
/** MySQL database username */
define('DB_USER', '{{bind.database.first.cfg.username}}');
/** MySQL database password */
define('DB_PASSWORD', '{{bind.database.first.cfg.password}}');
/** MySQL hostname */
define('DB_HOST', '{{bind.database.first.sys.ip}}');
/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');
/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');
/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 * WPSalts=$(wget https://api.wordpress.org/secret-key/1.1/salt/ -q -O -)
 * $WPSalts
 */
 define('AUTH_KEY',         'alhpp&zxM!A_cLydfwAHt!{bRfK)_[&vBnomtndZ?K}5Sh:r]3-2J9q[QadNQ$;q');
 define('SECURE_AUTH_KEY',  '?]r_TX`PH!<ZU_YKo3i1n}2;YQPKBVCQi@Rc%u|8kdCD#?j%[d/FN-L95@azrLrc');
 define('LOGGED_IN_KEY',    '}-(@G8)ePCG)@1LPh*Y-TA?rDis,mp;Z,MzQDeiuzXT1$[NdBp8s2~G1927+ib-r');
 define('NONCE_KEY',        '.0nUczGJ}q^S{/*1Pm;!U+H)XMw0?.+Rd{PkoXYSpMMrw1TEl]Ci`n)T-+p-<-*d');
 define('AUTH_SALT',        '+n-Z904uLwUf[fS(yJ`v2|LK+{H%-]rRo0i+vgj=ED^NDP4| +nq7c1V2LiqB[[j');
 define('SECURE_AUTH_SALT', 'W)#RiDm7m6Rj-cYTfPO&d?Pa>]&n8:rGzeL5]Zek|h4@)z:aV-.[[>6:y{2m}cw{');
 define('LOGGED_IN_SALT',   '#q-<*G+2|}dcwR.gqti+t}g[[KrfW`ez%?K._b+bd#y0g(w.9PWy>.Y=.@|=j|gP');
 define('NONCE_SALT',       'MZO22r,!91Pd=`K;IN-OO/5J^,KlInJQSYkl 5|J7^@-f1$xk:+]mwLUh%;DwS3D');
/**#@-*/
/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';
/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);
/* That's all, stop editing! Happy blogging. */
/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');
/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
