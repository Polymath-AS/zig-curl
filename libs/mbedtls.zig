const std = @import("std");
const ResolvedTarget = std.Build.ResolvedTarget;

pub fn create(b: *std.Build, target: ResolvedTarget, optimize: std.builtin.OptimizeMode) *std.Build.Step.Compile {
    const lib = b.addStaticLibrary(.{
        .name = "mbedtls",
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });

    lib.addCSourceFiles(.{ .files = srcs, .flags = &.{"-std=c99"} });
    lib.addIncludePath(.{ .path = "libs/mbedtls/include" });
    lib.addIncludePath(.{ .path = "libs/mbedtls/library" });
    lib.linkLibC();
    lib.installHeadersDirectory(.{ .path = "libs/mbedtls/include/mbedtls" }, "mbedtls", .{});
    lib.installHeadersDirectory(.{ .path = "libs/mbedtls/include/psa" }, "psa", .{});

    if (target.result.os.tag == .windows) {
        lib.linkSystemLibrary("ws2_32");
    }
    return lib;
}

const srcs = &.{
    "libs/mbedtls/library/aes.c",
    "libs/mbedtls/library/aesni.c",
    "libs/mbedtls/library/aesce.c",
    "libs/mbedtls/library/aria.c",
    "libs/mbedtls/library/asn1parse.c",
    "libs/mbedtls/library/asn1write.c",
    "libs/mbedtls/library/base64.c",
    "libs/mbedtls/library/bignum.c",
    "libs/mbedtls/library/bignum_core.c",
    "libs/mbedtls/library/bignum_mod.c",
    "libs/mbedtls/library/bignum_mod_raw.c",
    "libs/mbedtls/library/camellia.c",
    "libs/mbedtls/library/ccm.c",
    "libs/mbedtls/library/chacha20.c",
    "libs/mbedtls/library/chachapoly.c",
    "libs/mbedtls/library/cipher.c",
    "libs/mbedtls/library/cipher_wrap.c",
    "libs/mbedtls/library/constant_time.c",
    "libs/mbedtls/library/cmac.c",
    "libs/mbedtls/library/ctr_drbg.c",
    "libs/mbedtls/library/des.c",
    "libs/mbedtls/library/dhm.c",
    "libs/mbedtls/library/ecdh.c",
    "libs/mbedtls/library/ecdsa.c",
    "libs/mbedtls/library/ecjpake.c",
    "libs/mbedtls/library/ecp.c",
    "libs/mbedtls/library/ecp_curves.c",
    "libs/mbedtls/library/entropy.c",
    "libs/mbedtls/library/entropy_poll.c",
    "libs/mbedtls/library/error.c",
    "libs/mbedtls/library/gcm.c",
    "libs/mbedtls/library/hkdf.c",
    "libs/mbedtls/library/hmac_drbg.c",
    "libs/mbedtls/library/lmots.c",
    "libs/mbedtls/library/lms.c",
    "libs/mbedtls/library/md.c",
    "libs/mbedtls/library/md5.c",
    "libs/mbedtls/library/memory_buffer_alloc.c",
    "libs/mbedtls/library/nist_kw.c",
    "libs/mbedtls/library/oid.c",
    "libs/mbedtls/library/padlock.c",
    "libs/mbedtls/library/pem.c",
    "libs/mbedtls/library/pk.c",
    "libs/mbedtls/library/pk_wrap.c",
    "libs/mbedtls/library/pkcs12.c",
    "libs/mbedtls/library/pkcs5.c",
    "libs/mbedtls/library/pkparse.c",
    "libs/mbedtls/library/pkwrite.c",
    "libs/mbedtls/library/platform.c",
    "libs/mbedtls/library/platform_util.c",
    "libs/mbedtls/library/poly1305.c",
    "libs/mbedtls/library/psa_crypto.c",
    "libs/mbedtls/library/psa_crypto_aead.c",
    "libs/mbedtls/library/psa_crypto_cipher.c",
    "libs/mbedtls/library/psa_crypto_client.c",
    "libs/mbedtls/library/psa_crypto_ffdh.c",
    "libs/mbedtls/library/psa_crypto_driver_wrappers_no_static.c",
    "libs/mbedtls/library/psa_crypto_ecp.c",
    "libs/mbedtls/library/psa_crypto_hash.c",
    "libs/mbedtls/library/psa_crypto_mac.c",
    "libs/mbedtls/library/psa_crypto_pake.c",
    "libs/mbedtls/library/psa_crypto_rsa.c",
    "libs/mbedtls/library/psa_crypto_se.c",
    "libs/mbedtls/library/psa_crypto_slot_management.c",
    "libs/mbedtls/library/psa_crypto_storage.c",
    "libs/mbedtls/library/psa_its_file.c",
    "libs/mbedtls/library/psa_util.c",
    "libs/mbedtls/library/ripemd160.c",
    "libs/mbedtls/library/rsa.c",
    "libs/mbedtls/library/rsa_alt_helpers.c",
    "libs/mbedtls/library/sha1.c",
    "libs/mbedtls/library/sha3.c",
    "libs/mbedtls/library/sha256.c",
    "libs/mbedtls/library/sha512.c",
    "libs/mbedtls/library/threading.c",
    "libs/mbedtls/library/timing.c",
    "libs/mbedtls/library/version.c",
    "libs/mbedtls/library/version_features.c",
    "libs/mbedtls/library/pkcs7.c",
    "libs/mbedtls/library/x509.c",
    "libs/mbedtls/library/x509_create.c",
    "libs/mbedtls/library/x509_crl.c",
    "libs/mbedtls/library/x509_crt.c",
    "libs/mbedtls/library/x509_csr.c",
    "libs/mbedtls/library/x509write_crt.c",
    "libs/mbedtls/library/x509write_csr.c",
    "libs/mbedtls/library/debug.c",
    "libs/mbedtls/library/mps_reader.c",
    "libs/mbedtls/library/mps_trace.c",
    "libs/mbedtls/library/net_sockets.c",
    "libs/mbedtls/library/ssl_cache.c",
    "libs/mbedtls/library/ssl_ciphersuites.c",
    "libs/mbedtls/library/ssl_client.c",
    "libs/mbedtls/library/ssl_cookie.c",
    "libs/mbedtls/library/ssl_debug_helpers_generated.c",
    "libs/mbedtls/library/ssl_msg.c",
    "libs/mbedtls/library/ssl_ticket.c",
    "libs/mbedtls/library/ssl_tls.c",
    "libs/mbedtls/library/ssl_tls12_client.c",
    "libs/mbedtls/library/ssl_tls12_server.c",
    "libs/mbedtls/library/ssl_tls13_keys.c",
    "libs/mbedtls/library/ssl_tls13_server.c",
    "libs/mbedtls/library/ssl_tls13_client.c",
    "libs/mbedtls/library/ssl_tls13_generic.c",
};
